using Application.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.User
{
    public class UserService : IUserService
    {
        private readonly IUnitOfWork _unitOfWork;
        public UserService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public Domain.Entities.User GetUserByID(int id)
        {
            return _unitOfWork.User.Get(u => u.Id == id);
        }

        public void UpdateProfile(Domain.Entities.User user)
        {
           _unitOfWork.User.Update(user);
           _unitOfWork.User.Save();
        }
    }
}
