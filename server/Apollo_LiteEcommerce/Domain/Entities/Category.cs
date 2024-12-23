using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Entities
{
    [Table("Category")]
    public class Category
    {
        [Key]   
        public int CategoryID { get; set; }
        [Required]
        [MaxLength(100)]
        public string CategoryName { get; set; }
        public string Description { get; set; }
        public string? ImageUrl { get; set; }

        public virtual ICollection<Product>? Products { get; set; }

        [NotMapped]
        public IFormFile ImageFile {  get; set; }
    }
}
