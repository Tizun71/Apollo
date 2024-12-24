﻿using Domain.Entities;
using Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.Auth
{
    public interface IAuthService
    {
        Task<User> GetUserAsync(Domain.Entities.Auth auth);
        TokenModel GenerateToken(User user);
        string GenerateRefreshToken();
        ApiResponse RenewToken(TokenModel token);
    }
}