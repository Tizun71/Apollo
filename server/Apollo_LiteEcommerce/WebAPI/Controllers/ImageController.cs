using Application.Utils;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ImageController : ControllerBase
    {
        [HttpGet("{fileName}")]
        public IActionResult GetImage(string fileName)
        {
            var filePath = Path.Combine("Uploads", fileName);

            if (!System.IO.File.Exists(filePath))
            {
                return NotFound("File not found.");
            }

            var fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            var mimeType = "image/" + Path.GetExtension(fileName).Trim('.');
            return File(fileStream, mimeType);
        }

        [HttpPost]
        public IActionResult UploadImage(IFormFile image)
        {
            string filename = new UploadHelper().UploadFile(image);
            return Ok(filename);
        }
    }
}
