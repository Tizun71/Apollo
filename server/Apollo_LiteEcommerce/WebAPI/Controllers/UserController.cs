﻿using Application.Modules.Auth;
using Application.Modules.User;
using Application.Utils;
using Domain.Entities;
using Domain.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IAuthService _authService;
        private readonly IUserService _userService;

        public UserController(IAuthService authService, IUserService userService)
        {
            _authService = authService;
            _userService = userService;
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Vaildate(Auth model)
        {
            var user = await _authService.GetUserAsync(model);
            if (user == null)
            {
                return BadRequest(new
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

        [HttpPost("RegisterAccount")]
        public async Task<IActionResult> Register(UserDTO model)
        {
            //check 1: username || password null
            if (String.IsNullOrEmpty(model.username) || String.IsNullOrEmpty(model.password))
            {
                return BadRequest(new
                {
                    status = "ok",
                    message = "Username or password isn't empty"
                });
            }

            //check 2 : user exist
            var user = _userService.GetUserByUsername(model.username);
            if (user != null)
            {
                return BadRequest(new
                {
                    status = "ok",
                    message = "Username is exist"
                });
            }
            _userService.RegisterAccount(model);
            return Ok(new
            {
                status = "ok",
                message = "Register success",
            });            
        }

        [HttpPost("RenewToken")]
        public IActionResult RenewToken(TokenModel model)
        {
            return Ok(_authService.RenewToken);
        }

        [HttpGet]
        public IActionResult GetUser(int userId)
        {
            var user = _userService.GetUserByID(userId);
            string baseUrl = $"{Request.Scheme}://{Request.Host}";
            return Ok(new
            {
                status = "ok",
                user = new
                {
                    password = user.Password,
                    username = user.UserName,
                    email = user.Email,
                    fullName = user.FullName,
                    phone = user.Phone,
                    address = user.Address,
                    photoLink = user.ImageUrl != null ? baseUrl + Url.Action("GetImage", "Image", new { fileName = user.ImageUrl }) : null
                }
            });
        }

        [HttpPost("ChangeUserProfile")]
        public IActionResult ChangeUserProfile(int userId, [FromBody] UserDTO? model)
        {
            if (model == null)
            {
                return BadRequest();
            }
            if (userId <= 0)
            {
                return NotFound();
            }

            var user = _userService.GetUserByID(userId);
            if (model.fullname != null)
            {
                user.FullName = model.fullname;
            }
            if (model.email != null)
            {
                user.Email = model.email;
            }
            if (model.phone != null)
            {
                user.Phone = model.phone;
            }
            if (model.address != null)
            {
                user.Address = model.address;
            }
            _userService.UpdateProfile(user);
            return Ok(user);
        }
    }
}
