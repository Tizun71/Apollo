using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.User
{
    public interface IUserService
    {
        Domain.Entities.User GetUserByID(int id);
        void UpdateProfile(Domain.Entities.User user);
    }
}
