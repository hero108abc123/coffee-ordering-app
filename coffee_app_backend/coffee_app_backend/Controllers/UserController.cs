using coffee_app_backend.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using coffee_app_backend.Controllers;
using Microsoft.AspNetCore.Authorization;

namespace coffee_app_backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ApiControllerBase
    {
        private readonly IUserService _userService;
        public UserController(
            IUserService userService,
            ILogger<UserController> logger) : base(logger)
        {
            _userService = userService;
        }

        [Authorize]
        [HttpGet("get-user")]
        public IActionResult GetUser()
        {
            try
            {
                var user = _userService.GetUser();
                return Ok(user);
            }
            catch (Exception ex)
            {
                return ReturnException(ex);
            }
        }
    }
}
