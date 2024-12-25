using Application.Interfaces;
using Domain.Entities;
using Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.Order
{
    public class OrderService : IOrderService
    {
        private readonly IUnitOfWork _unitOfWork;

        public OrderService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<IEnumerable<Domain.Entities.Order>> GetAllAsync(int userId)
        {
            return await _unitOfWork.Order.List(o => o.UserID == userId);
        }

        public ApiResponse InvokeOrder(int userId, List<OrderDetailDTO> products)
        {
            var user = _unitOfWork.User.Get(u => u.Id == userId);
            if (user == null)
            {
                return new ApiResponse
                {
                    Success = false,
                    Message = "User isn't exist"
                };
            }

            var amount = 0;
            foreach (var product in products)
            {
                var p = _unitOfWork.Product.Get(p => p.ProductID == product.ProductID);
                if (p == null)
                {
                    return new ApiResponse
                    {
                        Success = false,
                        Message = "Product isn't exist"
                    };
                }
                amount = (int)(p.ProductPrice * product.Quantity);
            }

            var order = new Domain.Entities.Order
            {
                CreatedDate =  DateTime.UtcNow,
                UserID = userId,
                Status = 0,
                Amount = amount
            };

            _unitOfWork.Order.Add(order);
            _unitOfWork.Order.Save();

            foreach (var product in products)
            {
                var orderItem = new OrderDetail
                {
                    OrderID = order.OrderID,
                    ProductID = product.ProductID,
                    Quantity = product.Quantity,
                };
                _unitOfWork.OrderDetail.Add(orderItem);
                _unitOfWork.OrderDetail.Save();
            }
            return new ApiResponse 
            {
                Success = true,
            };
        }
    }
}
