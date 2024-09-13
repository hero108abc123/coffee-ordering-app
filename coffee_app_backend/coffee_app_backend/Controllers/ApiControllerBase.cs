using Azure.Identity;
using coffee_app_backend.Dtos.Exceptions;
using coffee_app_backend.Exceptions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace coffee_app_backend.Controllers
{
    public class ApiControllerBase : ControllerBase
    {
        protected ILogger _logger;
        public ApiControllerBase(ILogger logger)
        {
            _logger = logger;
        }

        protected IActionResult ReturnException(Exception ex)
        {
            if (ex is UserFriendlyException) 
            {
                var userEx = ex as UserFriendlyException;
                return StatusCode(StatusCodes.Status400BadRequest, new ExceptionBody
                {
                    Message = userEx.Message
                });
            }
            _logger.LogError(ex, ex.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, new ExceptionBody
            {
                Message = ex.Message,
            });
        }
    }
}
