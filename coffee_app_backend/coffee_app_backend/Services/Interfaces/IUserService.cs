using coffee_app_backend.Dtos.UserDtos;

namespace coffee_app_backend.Services.Interfaces
{
    public interface IUserService
    {
        UserDto GetUser();
    }
}
