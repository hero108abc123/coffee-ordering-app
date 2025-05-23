using coffee_app_backend.Dtos.CategoryDtos;
using coffee_app_backend.Dtos.Coffees;

namespace coffee_app_backend.Services.Interfaces
{
    public interface IProductService
    {
        Task AddCoffeeAsync(AddCoffeeDto input);
        Task<List<CoffeeDto>> GetCoffeesByCategoryAsync(int categoryId);
        Task<List<CategoryDto>> GetAllCategoriesAsync();
    }
}
