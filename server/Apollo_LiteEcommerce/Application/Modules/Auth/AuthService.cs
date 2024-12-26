using Application.Interfaces;
using Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.Extensions.Options;
using WebAPI.Models;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using Domain.Models;
using System.Security.Cryptography;

namespace Application.Modules.Auth
{
    public class AuthService : IAuthService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly AppSettings _appSettings;
        public AuthService(IUnitOfWork unitOfWork, IOptionsMonitor<AppSettings> optionsMonitor)
        {
            _unitOfWork = unitOfWork;
            _appSettings = optionsMonitor.CurrentValue;
        }

        public string GenerateRefreshToken()
        {
            var random = new byte[32];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(random);
            }
            return Convert.ToBase64String(random);
        }

        public TokenModel GenerateToken(User user)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(_appSettings.secretKey);
            var tokenDescription = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.Name, user.FullName),
                    new Claim(JwtRegisteredClaimNames.Email, user.Email),
                    new Claim(JwtRegisteredClaimNames.Sub, user.Email),
                     new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim("UserName", user.UserName),
                    new Claim("Id", user.Id.ToString()),

                    // roles

                    new Claim("TokenId", Guid.NewGuid().ToString()),
                }),
                Expires = DateTime.UtcNow.AddMinutes(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKeyBytes), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = jwtTokenHandler.CreateToken(tokenDescription);
            var accessToken = jwtTokenHandler.WriteToken(token);
            var refreshToken = GenerateRefreshToken();

            var refreshTokenEntity = new Domain.Entities.RefreshToken
            {
                Id = Guid.NewGuid(),
                JwtId = token.Id,
                UserId = user.Id,
                Token = refreshToken,
                IsUsed = false,
                IsRevoked = false,
                IssuedAt = DateTime.UtcNow,
                ExpiredAt = DateTime.UtcNow.AddHours(1),
            };

            _unitOfWork.RefreshToken.Add(refreshTokenEntity);
            _unitOfWork.RefreshToken.Save();

            return new TokenModel
            {
                AccessToken = accessToken,
                RefreshToken = refreshToken
            };
        }

        public async Task<User> GetUserAsync(Domain.Entities.Auth auth)
        {
            return await _unitOfWork.User.GetAsync(u => u.UserName ==  auth.UserName && u.Password == auth.Password);
        }

        public ApiResponse RenewToken(TokenModel token)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(_appSettings.secretKey);

            var tokenValidateParam = new TokenValidationParameters
            {
                ValidateIssuer = false,
                ValidateAudience = false,

                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(secretKeyBytes),
                ClockSkew = TimeSpan.Zero,

                ValidateLifetime =false,
            };

            try
            {
                //check 1: AccessToken valid format
                var tokenInVerification = jwtTokenHandler.ValidateToken(token.AccessToken, tokenValidateParam, out var validatedToken);

                //check 2: Check Alg
                if (validatedToken is JwtSecurityToken jwtSecurityToken)
                {
                    var result = jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha256, StringComparison.InvariantCultureIgnoreCase);
                    if (!result)
                    {
                        return new ApiResponse
                        {
                            Success = false,
                            Message = "Invalid token"
                        };
                    }
                }

                //check 3: check accessToken expire?
                var utcExpireDate = long.Parse(tokenInVerification.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Exp).Value);

                var expireDate = ConvertUnixTimeToDateTime(utcExpireDate);
                if (expireDate > DateTime.UtcNow)
                {
                    return new ApiResponse
                    {
                        Success = false,
                        Message = "Access token has not yet expired"
                    };
                }

                //check 4: Check refreshtoken exist in DB
                var storedToken = _unitOfWork.RefreshToken.Get(x => x.Token == token.RefreshToken);
                if (storedToken is null)
                {
                    return new ApiResponse
                    {
                        Success = false,
                        Message = "Refresh token does not exist"
                    };
                }

                //check 5: check refreshToken is used/revoked?
                if (storedToken.IsUsed)
                {
                    return new ApiResponse
                    {
                        Success = false,
                        Message = "Refresh token has been used"
                    };
                }
                if (storedToken.IsRevoked)
                {
                    return new ApiResponse
                    {
                        Success = false,
                        Message = "Refresh token has been revoked"
                    };
                }

                //check 6: AccessToken id == JwtId in RefreshToken
                var jti = tokenInVerification.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Jti).Value;
                if ( storedToken.JwtId != jti)
                {
                    return new ApiResponse
                    {
                        Success = false,
                        Message = "Token doesn't match"
                    };
                }

                //check 7: Update token is used
                storedToken.IsRevoked = true;
                storedToken.IsUsed = true;
                _unitOfWork.RefreshToken.Update(storedToken);
                _unitOfWork.RefreshToken.Save();

                //Create new token
                var user = _unitOfWork.User.Get(u => u.Id == storedToken.UserId);
                var generatedToken = GenerateToken(user);

                return new ApiResponse
                {
                    Success = true,
                    Message = "Renew token success",
                    Data = generatedToken

                };
            }
            catch (Exception ex)
            {
                return new ApiResponse
                {
                    Success = false,
                    Message = "Something went wrong"
                };
            }
        }

        private DateTime ConvertUnixTimeToDateTime(long utcExpireDate)
        {
            var dateTimeInterval = new DateTime(1970,1,1,0,0,0,0, DateTimeKind.Utc);
            dateTimeInterval.AddSeconds(utcExpireDate).ToUniversalTime();
            return dateTimeInterval;
        }
    }
}
