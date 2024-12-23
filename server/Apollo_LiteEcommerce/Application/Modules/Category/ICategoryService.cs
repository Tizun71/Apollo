using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.Category
{
    public interface ICategoryService
    {
        Task<IEnumerable<Domain.Entities.Category>> GetAllAsync();
        Task<Domain.Entities.Category> GetByIDAsync(int id);
        void CreateCategory(Domain.Entities.Category category);
        void UpdateCategory(Domain.Entities.Category category);
        void DeleteCategory(int id);
    }
}
