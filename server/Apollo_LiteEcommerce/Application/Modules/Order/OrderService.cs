using Application.Interfaces;
using Domain.Constants;
using Domain.Entities;
using Domain.Models;
using System;
using System.Buffers;
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
            return await _unitOfWork.Order.List(
                o => o.UserID == userId ,
                query => query.OrderByDescending(o => o.OrderID)
            );
        }

        public async Task<Domain.Entities.Order> GetByIDAsync(int orderId)
        {
            return await _unitOfWork.Order.GetAsync(o => o.OrderID == orderId);
        }
        public async Task<IEnumerable<OrderDetailDTO>> GetOrderDetailByIdAsync(int orderId)
        {
            var orderDetailDtos = new List<OrderDetailDTO>(); 
            var orderDetails = await _unitOfWork.OrderDetail.List(o => o.OrderID == orderId);

            foreach (var orderDetail in orderDetails)
            {
                var product = await _unitOfWork.Product.GetAsync(p => p.ProductID == orderDetail.ProductID);
                orderDetailDtos.Add(new OrderDetailDTO
                {
                    ProductID = orderDetail.ProductID,
                    Quantity = orderDetail.Quantity,
                    ProductItem = product,
                });
            }

            return orderDetailDtos;
        }

        public ApiResponse InvokeOrder(int userId, string? note, List<OrderDetailDTO> products)
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
                amount += (int)(p.ProductPrice * product.Quantity * (1.0 - p.Sale / 100.0));
            }

            var order = new Domain.Entities.Order
            {
                CreatedDate =  DateTime.UtcNow,
                UserID = userId,
                Status = (int) OrderStatus.PENDING,
                Amount = amount,
                Note = note
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

        public ApiResponse ConfirmOrder(Domain.Entities.Order order)
        {
            if (order.Status != (int) OrderStatus.PENDING)
            {
                return new ApiResponse
                {
                    Success = false,
                    Message = "Order status isn't pending"
                };
            }

            order.Status = (int)OrderStatus.PROCESSING;
            _unitOfWork.Order.Update(order);
            _unitOfWork.Order.Save();
            return new ApiResponse
            {
                Success = true,
            };
        }

        public ApiResponse DeliveryOrder(Domain.Entities.Order order)
        {
            if (order.Status != (int)OrderStatus.PROCESSING)
            {
                return new ApiResponse
                {
                    Success = false,
                    Message = "Order status isn't processing"
                };
            }
            order.Status = (int)OrderStatus.DELIVERING;
            _unitOfWork.Order.Update(order);
            _unitOfWork.Order.Save();
            return new ApiResponse
            {
                Success = true,
            };
        }

        public ApiResponse ReceiveOrder(Domain.Entities.Order order)
        {
            if (order.Status != (int)OrderStatus.DELIVERING)
            {
                return new ApiResponse
                {
                    Success = false,
                    Message = "Order status isn't delivering"
                };
            }
            order.Status = (int) OrderStatus.COMPLETED;
            _unitOfWork.Order.Update(order);
            _unitOfWork.Order.Save();
            return new ApiResponse
            {
                Success = true,
            };
        }

        public ApiResponse CancelOrder(Domain.Entities.Order order)
        {
            if (order.Status != (int)OrderStatus.PENDING || order.Status != (int) OrderStatus.PROCESSING)
            {
                return new ApiResponse
                {
                    Success = false,
                    Message = "Order status isn't pending or processing"
                };
            }
            order.Status = (int)OrderStatus.CANCELED;
            _unitOfWork.Order.Update(order);
            _unitOfWork.Order.Save();
            return new ApiResponse
            {
                Success = true,
            };
        }
    }
}
