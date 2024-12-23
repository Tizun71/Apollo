using Application.Modules.Product;
using Application.Utils;
using Domain.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ProductAPIController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductAPIController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Product>>> GetProductAsync(int page, int pageSize, string? searchValue, int? categoryID, string? sortType)
        {
            var data = await _productService.PaginatedAsync(page, pageSize, searchValue, categoryID, sortType);
            string baseUrl = $"{Request.Scheme}://{Request.Host}";
            var result = data.Select(product => new
            {
                name = product.ProductName,
                description = product.ProductDescription,
                price = product.ProductPrice,
                salePercentage = product.Sale,
                photoLink = product.ImageUrl != null ? baseUrl + Url.Action("GetImage", "Image", new { fileName = product.ImageUrl }) : null
            });

            return Ok(new
            {
                status = "ok",
                products = result
            });
        }

        [HttpPost]
        public IActionResult CreateProduct([FromForm] Product model)
        {
            if (model == null)
            {
                return BadRequest();
            }
            if (model.ProductID > 0)
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
            var product = new Product
            {
                ProductName = model.ProductName,
                ProductDescription = model.ProductDescription,
                ProductPrice = model.ProductPrice,
                Sale = model.Sale,
            };
            if (model.ImageFile.Length > 0)
            {
                string filename = new UploadHelper().UploadFile(model.ImageFile);
                model.ImageUrl = filename;
            }
            _productService.CreateProduct(model);
            return CreatedAtAction("GetProduct", new { id = model.ProductID }, model);
        }
    }
}
