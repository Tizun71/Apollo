using Application.Modules.Order;
using Domain.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderService _orderService;

        public OrderController(IOrderService orderService)
        {
            _orderService = orderService;
        }

        [HttpPost]
        public IActionResult InvokeOrder(int userId, string? note, List<OrderDetailDTO> products)
        {
            return Ok(_orderService.InvokeOrder(userId, note, products));
        }

        [HttpGet]
        public async Task<IActionResult> GetAllOrders(int userId)
        {
            string baseUrl = $"{Request.Scheme}://{Request.Host}";
            var data = await _orderService.GetAllAsync(userId);
            var result = new List<object>();
            foreach (var order in data)
            {
                var orderDetailTask = await _orderService.GetOrderDetailByIdAsync(order.OrderID);
                var orderDetails = orderDetailTask
                .Select(detail => new {
                    photoLink = detail.ProductItem.ImageUrl != null ? baseUrl + Url.Action("GetImage", "Image", new { fileName = detail.ProductItem.ImageUrl }) : null,
                    detail.ProductItem.ProductName,
                    detail.Quantity,
                    productPrice = detail.ProductItem.ProductPrice * (1 - detail.ProductItem.Sale / 100.0)
                });
            
                result.Add(new
                {
                    orderID = order.OrderID,
                    createdDate = order.CreatedDate.ToString("dd/MM/yyyy"),
                    status = order.Status,
                    amount = order.Amount,
                    note = order.Note,
                    orderDetails 
                });
            }

            return Ok(new
            {
                status = "ok",
                orders = result
            });
        }

        [HttpPost]
        public async Task<IActionResult> ConfirmOrder(int orderId)
        {
            var order = await _orderService.GetByIDAsync(orderId);
            if (order == null)
            {
                return Ok(new
                {
                    Success = false,
                    Message = "Order isn't exist"
                });
            }
            return Ok(_orderService.ConfirmOrder(order));
        }

        [HttpPost]
        public async Task<IActionResult> DeliveryOrder(int orderId)
        {
            var order = await _orderService.GetByIDAsync(orderId);
            if (order == null)
            {
                return Ok(new
                {
                    Success = false,
                    Message = "Order isn't exist"
                });
            }
            return Ok(_orderService.DeliveryOrder(order));
        }

        [HttpPost]
        public async Task<IActionResult> ReceiveOrder(int orderId)
        {
            var order = await _orderService.GetByIDAsync(orderId);
            if (order == null)
            {
                return Ok(new
                {
                    Success = false,
                    Message = "Order isn't exist"
                });
            }
            return Ok(_orderService.ReceiveOrder(order));
        }

        [HttpPost]
        public async Task<IActionResult> CancelOrder(int orderId)
        {
            var order = await _orderService.GetByIDAsync(orderId);
            if (order == null)
            {
                return Ok(new
                {
                    Success = false,
                    Message = "Order isn't exist"
                });
            }
            return Ok(_orderService.CancelOrder(order));
        }
    }
}
