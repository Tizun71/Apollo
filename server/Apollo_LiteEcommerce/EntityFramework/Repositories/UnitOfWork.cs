using Application.Interfaces;
using Domain.Entities;
using EntityFramework.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntityFramework.Repositories
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ApplicationDbContext _context;
        public ICategoryRepository Category {  get; private set; }

        public IProductRepository Product { get; private set; }
        public IUserRepository User { get; private set; }

        public IRefreshTokenRepository RefreshToken { get; private set; }

        public UnitOfWork(ApplicationDbContext context)
        {
            _context = context;
            Category = new CategoryRepository(_context);
            Product = new ProductRepository(_context);
            User = new UserRepository(_context);
            RefreshToken = new RefreshTokenRepository(_context);
        }
    }
}
