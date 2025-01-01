using Application.Interfaces;
using Domain.Entities;
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

        public Domain.Entities.User GetUserByUsername(string username)
        {
            return _unitOfWork.User.Get(u => u.UserName == username);
        }

        public void RegisterAccount(UserDTO userDTO)
        {
            var user = new Domain.Entities.User
            {
                UserName = userDTO.username,
                FullName = userDTO.fullname,
                Email = userDTO.email,
                Phone = userDTO.phone,
                Address = userDTO.address,
                Password = userDTO.password
            };
            _unitOfWork.User.Add(user);
            _unitOfWork.User.Save();
        }

        public void UpdateProfile(Domain.Entities.User user)
        {
           _unitOfWork.User.Update(user);
           _unitOfWork.User.Save();
        }
    }
}
