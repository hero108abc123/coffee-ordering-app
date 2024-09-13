using coffee_app_backend.Dbcontexts;
using coffee_app_backend.Dtos.UserDtos;
using coffee_app_backend.Exceptions;
using coffee_app_backend.Services.Interfaces;
using SoundSpace.Utils;

namespace coffee_app_backend.Services.Implements
{
    public class UserService : IUserService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UserService(ILogger<UserService> logger, ApplicationDbContext dbContext, IHttpContextAccessor httpContextAccessor)
        {
            _dbContext = dbContext;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
        }
       
        public UserDto GetUser()
        {
            int currentUserId = CommonUntils.GetCurrentUserId(_httpContextAccessor);
            var user = _dbContext.Users.FirstOrDefault((u) => u.Id == currentUserId);
            if (user != null)
            {
                var result = new UserDto
                {
                    Id = user.Id,
                    Username = user.Username,
                    MobileNumber = user.MobileNumber,
                };
                return result;
            }
            throw new UserFriendlyException($"User not found!");

        }
    }
}
