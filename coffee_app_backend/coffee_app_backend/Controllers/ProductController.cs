using coffee_app_backend.Dtos.Coffees;
using coffee_app_backend.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace coffee_app_backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ApiControllerBase
    {
        private readonly IProductService _productService;

        public ProductController(
            ILogger<ProductController> logger,
            IProductService productService) : base(logger)
        {
            _productService = productService;
        }

        [Authorize]
        [HttpGet("categories")]
        public async Task<IActionResult> GetAllCategories()
        {
            try
            {
                var result = await _productService.GetAllCategoriesAsync();
                return Ok(result);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [Authorize]
        [HttpGet("coffees/{categoryId}")]
        public async Task<IActionResult> GetCoffeesByCategory(int categoryId)
        {
            try
            {
                var result = await _productService.GetCoffeesByCategoryAsync(categoryId);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
 // Chỉ người dùng đăng nhập mới được thêm coffee
        [HttpPost("add-coffee")]
        public async Task<IActionResult> AddCoffee([FromForm] AddCoffeeDto input)
        {
            try
            {
                await _productService.AddCoffeeAsync(input);
                return Ok(new { message = "Coffee added successfully" });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}
