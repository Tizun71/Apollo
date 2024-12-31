using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Entities
{
    [Table("Order")]
    public class Order
    {
        [Key]
        public int OrderID { get; set; }
        public DateTime CreatedDate { get; set; }
        public int UserID { get; set; }
        [ForeignKey(nameof(UserID))]
        public User User { get; set; }
        public int Status { get; set; }
        public int Amount { get; set; }
        public string? Note { get; set; }
    }
}
