using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Entities
{
    [Table("OrderDetail")]
    public class OrderDetail
    {
        [Key]
        public int OrderDetailID { get; set; }
        public int OrderID { get; set; }
        [ForeignKey(nameof(OrderID))]
        public Order Order { get; set; }
        public int ProductID { get; set; }
        [ForeignKey(nameof(ProductID))]
        public Product Product { get; set; }
        public int Quantity { get; set; }
    }
}
