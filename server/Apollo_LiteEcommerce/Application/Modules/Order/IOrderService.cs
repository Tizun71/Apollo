using Domain.Entities;
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
        Task<IEnumerable<OrderDetailDTO>> GetOrderDetailByIdAsync(int orderId);
        Task<Domain.Entities.Order> GetByIDAsync(int orderId);
        ApiResponse InvokeOrder(int userId, string? note, List<OrderDetailDTO> products);
        ApiResponse ConfirmOrder(Domain.Entities.Order order);
        ApiResponse DeliveryOrder(Domain.Entities.Order order);
        ApiResponse ReceiveOrder(Domain.Entities.Order order);
        ApiResponse CancelOrder(Domain.Entities.Order order);
    }
}
