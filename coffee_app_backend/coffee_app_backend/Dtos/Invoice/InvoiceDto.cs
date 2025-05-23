using coffee_app_backend.Dtos.CartItem;
using coffee_app_backend.Entities;
using System.ComponentModel.DataAnnotations.Schema;

namespace coffee_app_backend.Dtos.Invoice
{
    public class InvoiceDto
    {
        public int Id { get; set; }
        public string PaymendMethod { get; set; }
        public double Discount { get; set; }
        public double Vat { get; set; }
        public string Date { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public double TotalPrice { get; set; }

        public List<CartItemDto> Items { get; set; }
    }
}
