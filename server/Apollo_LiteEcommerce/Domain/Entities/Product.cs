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
    [Table("Product")]
    public class Product
    {
        [Key]
        public int ProductID { get; set; }
        [Required]
        [MaxLength(100)]
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }

        [Range(0, double.MaxValue)]
        public double ProductPrice { get; set; }
        public byte Sale { get; set; }

        public string? ImageUrl { get; set; }
        [NotMapped]
        public IFormFile ImageFile { get; set; }

        public int? CategoryID { get; set; }
        [ForeignKey("CategoryID")]
        public Category? Category { get; set; }
    }
}
