using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IRepository<T> where T : class
    {
        Task<IEnumerable<T>> List(Expression<Func<T, bool>>? filter = null);
        Task<IEnumerable<T>> Paged(int page = 0, int pageSize = 0, Expression<Func<T, bool>>? filter = null, Func<IQueryable<T>, IOrderedQueryable<T>>? orderBy = null);
        Task<int> Count(Expression<Func<T, bool>>? filter = null);
        Task<T> GetAsync(Expression<Func<T, bool>>? filter = null);
        T Get(Expression<Func<T, bool>>? filter = null);
        void Add(T entity);
        void Update(T entity);
        void Remove(T entity);
        void Save();
        bool IsExist(T entity);
    }
}
