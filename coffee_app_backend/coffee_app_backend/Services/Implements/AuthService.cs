using coffee_app_backend.Dbcontexts;
using coffee_app_backend.Dtos.AuthDtos;
using coffee_app_backend.Entities;
using coffee_app_backend.Exceptions;
using coffee_app_backend.Services.Interfaces;
using Microsoft.IdentityModel.Tokens;
using SoundSpace.Utils;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace coffee_app_backend.Services.Implements
{
    public class AuthService : IAuthService
    {
        private readonly ILogger _logger;
        private readonly ApplicationDbContext _dbContext;
        private readonly IConfiguration _configuration;
        public AuthService(
            ILogger<UserService> logger,
            ApplicationDbContext dbContext,
            IConfiguration configuration)
        {
            _configuration = configuration;
            _logger = logger;
            _dbContext = dbContext;

        }

        public void CreateUser(CreateUserDto input)
        {
            if (_dbContext.Users.Any(u => u.Email == input.Email))
            {
                throw new UserFriendlyException($"The account name \"{input.Email}\" already exists!");
            }
            if (_dbContext.Users.Any(u => u.Username == input.UserName))
            {
                throw new UserFriendlyException($"User \"{input.UserName}\" already exists");
            }
            var user = _dbContext.Users.Add(new User
            {
                Username = input.UserName,
                MobileNumber = input.MobileNumber,
                Email = input.Email,
                Password = PasswordHasher.HashPassword(input.Password),
            });
            _dbContext.SaveChanges();
        }


        public string Login(LoginDto input)
        {
            var user = _dbContext.Users.FirstOrDefault(u => u.Email == input.Email);
            if (user == null)
            {
                throw new UserFriendlyException($"User not found!");
            }

            if (PasswordHasher.VerifyPassword(input.Password, user.Password))
            {
                var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Secret"]));
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, user.Id.ToString()),
                    new Claim("userId", user.Id.ToString()),
                    new Claim("userEmail", user.Email),
                };

                var token = new JwtSecurityToken(
                    issuer: _configuration["JWT:ValidIssuer"],
                    audience: _configuration["JWT:ValidAudience"],
                    expires: DateTime.Now.AddSeconds(_configuration.GetValue<int>("JWT:Expires")),
                    claims: claims,
                    signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
                );

                return new JwtSecurityTokenHandler().WriteToken(token);
            }
            else
            {
                throw new UserFriendlyException($"Wrong password!");
            }
        }

        public void ForgotPassword(ForgotPasswordDto input)
        {
            var emailFind = _dbContext.Users.FirstOrDefault(u => u.Email == input.Email);
            if (emailFind == null)
            {
                throw new UserFriendlyException($"Account not found!");
            }
        }
    }
}
