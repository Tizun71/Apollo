using Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.Order
{
    public interface IOrderService
    {
        Task<IEnumerable<Domain.Entities.Order>> GetAllAsync(int userId);
        ApiResponse InvokeOrder(int userId, List<OrderDetailDTO> products);
    }
}
