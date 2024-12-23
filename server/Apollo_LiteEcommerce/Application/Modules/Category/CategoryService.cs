using Application.Interfaces;
using Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.Category
{
    public class CategoryService : ICategoryService
    {
        private readonly IUnitOfWork _unitOfWork;
        public CategoryService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<IEnumerable<Domain.Entities.Category>> GetAllAsync()
        {
            return await _unitOfWork.Category.List();
        }

        public async Task<Domain.Entities.Category> GetByIDAsync(int id)
        {
            return await _unitOfWork.Category.GetAsync(c => c.CategoryID == id);
        }
        public void CreateCategory(Domain.Entities.Category category)
        {
            _unitOfWork.Category.Add(category);
            _unitOfWork.Category.Save();
        }

        public void DeleteCategory(int id)
        {
            Domain.Entities.Category category = _unitOfWork.Category.Get(c => c.CategoryID==id);
            _unitOfWork.Category.Remove(category);
            _unitOfWork.Category.Save();
        }

        public void UpdateCategory(Domain.Entities.Category category)
        {
            _unitOfWork.Category.Update(category);
            _unitOfWork.Category.Save();
        }
    }
}
