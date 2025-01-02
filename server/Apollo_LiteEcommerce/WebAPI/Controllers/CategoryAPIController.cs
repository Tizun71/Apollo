using Application.Interfaces;
using Application.Modules.Category;
using Application.Utils;
using Domain.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CategoryAPIController : ControllerBase
    {
        private readonly ICategoryService _categoryService;

        public CategoryAPIController(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Category>>> GetAllAsync()
        {
            var data = await _categoryService.GetAllAsync();
            string baseUrl = $"{Request.Scheme}://{Request.Host}";
            var result = data.Select(category => new
            {
                id = category.CategoryID,
                name = category.CategoryName,
                photoLink = category.ImageUrl != null ? baseUrl + Url.Action("GetImage", "Image", new { fileName = category.ImageUrl }) : null
            });

            return Ok(new
            {
                status = "ok",
                categories = result
            });
        }

        [HttpGet("{id:int}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<Category>> GetCategoryAsync(int id)
        {
            if (id == 0)
            {
                return BadRequest();
            }
            var category = await _categoryService.GetByIDAsync(id);
            if (category == null)
            {
                return NotFound();
            }

            return Ok(category);
        }

        [HttpPost]
        public IActionResult CreateCategory([FromForm] Category model)
        {
            if (model == null)
            {
                return BadRequest();
            }
            if (model.CategoryID > 0)
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
            var category = new Category
            {
                CategoryName = model.CategoryName,
                Description = model.Description
            };
            if (model.ImageFile.Length > 0)
            {
                string filename = new UploadHelper().UploadFile(model.ImageFile);
                model.ImageUrl = filename;
            }
            _categoryService.CreateCategory(model);
            return CreatedAtAction("GetCategory", new {id = model.CategoryID}, model);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> UpdateCategory(int id, [FromForm] Category model)
        {
            if (model == null)
            {
                return BadRequest();
            }
            var category = await _categoryService.GetByIDAsync(id);
            if (category == null)
            {
                return NotFound();
            }
            if (model.CategoryName != null)
            {
                category.CategoryName = model.CategoryName;
            }
            if (model.Description != null)
            {
                category.Description = model.Description;
            }
                
            if (model.ImageFile.Length > 0)
            {
                string filename = new UploadHelper().UploadFile(model.ImageFile);
                model.ImageUrl = filename;
            }
            _categoryService.UpdateCategory(model);
            return NoContent();
        }

        [HttpDelete("{id:int}")]
        public IActionResult DeleteCategory(int id)
        {
            if (id == 0)
            {
                return BadRequest();
            }
            _categoryService.DeleteCategory(id);
            return NoContent();
        }
    }
}
