using coffee_app_backend.Dbcontexts;
using coffee_app_backend.Dtos.CategoryDtos;
using coffee_app_backend.Dtos.Coffees;
using coffee_app_backend.Entities;
using coffee_app_backend.Exceptions;
using coffee_app_backend.Services.Interfaces;
using coffee_app_backend.Utils;
using Microsoft.EntityFrameworkCore;

namespace coffee_app_backend.Services.Implements
{
    public class ProductService : IProductService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public ProductService(ILogger<ProductService> logger, ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor)
        {
             _dbContext = dbContext;
            _httpContextAccessor = httpContextAccessor;
            _logger = logger;
        }

        public async Task<List<CategoryDto>> GetAllCategoriesAsync()
        {
                var categories = await _dbContext.Categories
                    .Select(c => new CategoryDto
                    {
                        Id = c.Id,
                        Name = c.CategoryName
                    })
                    .ToListAsync();

                return categories;
            
        }

        public async Task<List<CoffeeDto>> GetCoffeesByCategoryAsync(int categoryId)
        {
            var coffees = await _dbContext.Coffees
                .Where(c => c.CategoryId == categoryId)
                .Select(c => new CoffeeDto
                {
                    Id = c.Id,
                    Image = UploadFile.GetFileUrl(c.Image, _httpContextAccessor),
                    Name = c.Name,
                    Type = c.Type,
                    Rate = c.Rate,
                    Review = c.Review,
                    Description = c.Description,
                    Price = c.Price,
                    Category = c.Category.CategoryName,
                })
                .ToListAsync();

            return coffees;
        }

        public async Task AddCoffeeAsync(AddCoffeeDto input)
        {
            // Kiểm tra trùng tên Coffee
            if (_dbContext.Coffees.Any(c => c.Name == input.Name))
            {
                throw new UserFriendlyException($"Coffee \"{input.Name}\" already exists");
            }

            // Lưu ảnh nếu có
            string imagePath = null;
            if (input.Image != null)
            {
                imagePath = await UploadFile.SaveFileAsync(input.Image, "Coffees", "Images");
            }

            // Tạo đối tượng Coffee mới
            var coffee = new Coffee
            {
                Name = input.Name,
                Type = input.Type,
                Rate = input.Rate,
                Review = input.Review,
                Description = input.Description,
                Price = input.Price,
                CategoryId = input.CategoryId,
                Image = imagePath
            };

            // Lưu vào database
            _dbContext.Coffees.Add(coffee);
            await _dbContext.SaveChangesAsync();
        }


    }
}
