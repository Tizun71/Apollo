using Application.Modules.Order;
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
        public IActionResult InvokeOrder(int userId, List<OrderDetailDTO> products)
        {
            return Ok(_orderService.InvokeOrder(userId, products));
        }

        [HttpGet]
        public async Task<IActionResult> GetAllOrders(int userId)
        {
            var data = await _orderService.GetAllAsync(userId);
            var result = data.Select(order => new
            {
                orderID = order.OrderID,
                createdDate = order.CreatedDate.ToString("dd/MM/yyyy"),
                status = order.Status,
                amount = order.Amount
            });
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
