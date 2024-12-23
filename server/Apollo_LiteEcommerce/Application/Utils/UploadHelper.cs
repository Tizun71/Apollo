using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Utils
{
    public class UploadHelper
    {
        public string UploadFile(IFormFile file)
        {
            //Extension
            List<string> validExtentions = new List<string>() { ".jpg", ".png"};
            string extension = Path.GetExtension(file.FileName);
            if (!validExtentions.Contains(extension))
            {
                return $"Extension is not valid ({string.Join(',', validExtentions)})";
            }
            //File Size
            long size = file.Length;
            if (size > (5 * 1024 * 1024))
                return "Maximum can be 5mb";
            //Name changing
            string fileName = Guid.NewGuid().ToString() + extension;
            string path = Path.Combine(Directory.GetCurrentDirectory(), "Uploads");
            using FileStream stream = new FileStream(Path.Combine(path, fileName) , FileMode.Create);
            file.CopyTo(stream);
            
            return fileName;
        }
    }
}
