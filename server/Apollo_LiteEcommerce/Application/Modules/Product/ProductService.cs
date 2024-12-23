using Application.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.Product
{
    public class ProductService : IProductService
    {
        private readonly IUnitOfWork _unitOfWork;
        public ProductService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        public async Task<IEnumerable<Domain.Entities.Product>> PaginatedAsync(int page, int pageSize, string? searchValue, int? categoryID, string? sortType = "desc")
        {
            IEnumerable<Domain.Entities.Product> lst = null;
            if (sortType == "desc")
            {
                lst = await _unitOfWork.Product.Paged(page, pageSize,
                p =>    (string.IsNullOrEmpty(searchValue) || p.ProductName.Contains(searchValue)) &&
                        (!categoryID.HasValue || p.CategoryID == categoryID),
                query => query.OrderByDescending(p => p.ProductID)
                );
            }
            else
            {
                lst = await _unitOfWork.Product.Paged(page, pageSize,
                p =>    (string.IsNullOrEmpty(searchValue) || p.ProductName.Contains(searchValue)) &&
                        (!categoryID.HasValue || p.CategoryID == categoryID),
                query => query.OrderBy(p => p.ProductID)
                );
            }
            return lst;
        }

        public void CreateProduct(Domain.Entities.Product product)
        {
            _unitOfWork.Product.Add(product);
            _unitOfWork.Product.Save();
        }
    }
}
