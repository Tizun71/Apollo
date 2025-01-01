using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Modules.User
{
    public class UserDTO
    {
        public string? username { get; set; } = string.Empty;
        public string? fullname {  get; set; } = string.Empty;
        public string? password { get; set; } = string.Empty;
        public string? email { get; set; } = string.Empty;
        public string? phone { get; set; } = string.Empty;
        public string? address { get; set; } = string.Empty;
        public string? ImageUrl { get; set; } = string.Empty;
        public IFormFile? ImageFile { get; set; }
    }
}
