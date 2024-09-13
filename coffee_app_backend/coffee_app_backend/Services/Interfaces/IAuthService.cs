using coffee_app_backend.Dtos.AuthDtos;

namespace coffee_app_backend.Services.Interfaces
{
    public interface IAuthService
    {
        void CreateUser(CreateUserDto input);
        string Login(LoginDto input); 
        void ForgotPassword(ForgotPasswordDto input);
    }
}
