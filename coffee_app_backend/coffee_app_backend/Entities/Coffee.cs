using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace coffee_app_backend.Entities
{
    public class Coffee
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public string Image { get; set; }

        public string Name { get; set; }
        public string Type { get; set; }

        public double Rate { get; set; }
        public int Review { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }

        [ForeignKey("Category")]
        public int CategoryId { get; set; }
        public Category Category { get; set; }

        public ICollection<FavoriteCoffee> Users { get; set; } = new List<FavoriteCoffee>();

        public ICollection<CartItem> Invoices { get; set; } = new List<CartItem>();
    }
}
