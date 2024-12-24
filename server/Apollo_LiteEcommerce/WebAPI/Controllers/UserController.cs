using Application.Modules.Auth;
using Domain.Entities;
using Domain.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IAuthService _authService;

        public UserController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Vaildate(Auth model)
        {
            var user = await _authService.GetUserAsync(model);
            if (user == null)
            {
                return Ok(new
                {
                    Success = false,
                    Message = "Invalid username / password"
                });
            }

            var token = _authService.GenerateToken(user);

            return Ok(new
            {
                Success = true,
                Message = "Authenticate success",
                Data = token
            });
        }

        [HttpPost("RenewToken")]
        public IActionResult RenewToken(TokenModel model)
        {
            return Ok(_authService.RenewToken);
        }
    }
}
