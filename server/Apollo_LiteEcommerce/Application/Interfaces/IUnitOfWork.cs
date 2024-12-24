using Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IUnitOfWork
    {
        ICategoryRepository Category {  get; }
        IProductRepository Product { get; }
        IUserRepository User { get; }

        IRefreshTokenRepository RefreshToken { get; }
    }
}
