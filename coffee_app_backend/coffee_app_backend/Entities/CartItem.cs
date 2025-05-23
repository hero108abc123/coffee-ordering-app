using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace coffee_app_backend.Entities
{
    public class CartItem
    {
        [ForeignKey("Coffee")]
        public int CoffeeId { get; set; }
        public Coffee Coffee { get; set; }
        public int Quantity { get; set; }
        public string Size{ get; set; }

        [ForeignKey("Invoice")]
        public int InvoiceId { get; set; }
        public Invoice Invoice { get; set; }
    }
}
