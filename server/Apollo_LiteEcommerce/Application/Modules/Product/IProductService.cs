using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.Product
{
    public interface IProductService
    {
        Task<IEnumerable<Domain.Entities.Product>> PaginatedAsync(int page, int pageSize, string searchValue, int? categoryID, string sortType = "desc");
        void CreateProduct(Domain.Entities.Product product);
    }
}
