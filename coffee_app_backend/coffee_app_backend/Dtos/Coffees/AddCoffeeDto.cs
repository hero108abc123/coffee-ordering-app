using System.ComponentModel.DataAnnotations;

namespace coffee_app_backend.Dtos.Coffees
{
    public class AddCoffeeDto
    {
        public IFormFile Image { get; set; }

        private string _name;

        [Required]
        [StringLength(30, ErrorMessage = "Name must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string Name
        {
            get => _name;
            set => _name = value?.Trim();
        }

        private string _type;

        [Required]
        [StringLength(30, ErrorMessage = "Type must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string Type
        {
            get => _type;
            set => _type = value?.Trim();
        }

        public double Rate { get; set; }
        public int Review { get; set; }
        private string _description;

        [Required]
        [StringLength(30, ErrorMessage = "Description must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string Description
        {
            get => _description;
            set => _description = value?.Trim();
        }
        public double Price { get; set; }

        public int CategoryId { get; set; }
    }
}
