namespace coffee_app_backend.Dtos.Coffees
{
    public class CoffeeDto
    {
        public int Id { get; set; }

        public string Image { get; set; }

        public string Name { get; set; }
        public string Type { get; set; }

        public double Rate { get; set; }
        public int Review { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }
        public string Category { get; set; }
    }
}
