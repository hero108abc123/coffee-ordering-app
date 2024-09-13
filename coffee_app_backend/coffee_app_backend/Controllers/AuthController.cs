using coffee_app_backend.Dtos.AuthDtos;
using coffee_app_backend.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using coffee_app_backend.Controllers;

namespace coffee_app_backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ApiControllerBase
    {
        private readonly IAuthService _authService;
        public AuthController(
            IAuthService authService,
            ILogger<AuthController> logger) : base(logger)
        {
            _authService = authService;
        }

        [HttpPost("create")]
        public IActionResult CreateUser(CreateUserDto input)
        {
            try
            {
                _authService.CreateUser(input);
                return Ok();
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpPost("login")]
        public IActionResult Login(LoginDto input)
        {
            try
            {
                string token = _authService.Login(input);
                return Ok(new { token });
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }

        [HttpPost("forgot-password")]
        public IActionResult ForgotPassword(ForgotPasswordDto input)
        {
            try
            {
                _authService.ForgotPassword(input);
                return Ok();
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}
