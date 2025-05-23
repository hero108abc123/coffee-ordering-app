using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Runtime.ConstrainedExecution;

namespace coffee_app_backend.Entities
{
    public class Invoice
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string PaymendMethod { get; set; }
        public double Discount { get; set; }
        public double Vat { get; set; }
        public DateOnly Date { get; set; }
        public double TotalPrice { get; set; }

        [ForeignKey("User")]
        public int UserId { get; set; }
        public User User { get; set; }

        public ICollection<CartItem> Coffees { get; set; } = new List<CartItem>();
    }
}
