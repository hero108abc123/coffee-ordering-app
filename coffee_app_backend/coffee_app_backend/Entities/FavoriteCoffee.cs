using System.ComponentModel.DataAnnotations.Schema;

namespace coffee_app_backend.Entities
{
    public class FavoriteCoffee
    {
        [ForeignKey("User")]
        public int UserId { get; set; }
        public User User { get; set; }

        [ForeignKey("Coffee")]
        public int CoffeeId { get; set; }
        public Coffee Coffee { get; set; }
    }
}
