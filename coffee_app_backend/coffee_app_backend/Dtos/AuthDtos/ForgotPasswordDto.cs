using System.ComponentModel.DataAnnotations;

namespace coffee_app_backend.Dtos.AuthDtos
{
    public class ForgotPasswordDto
    {

        private string _email;
        [Required]
        [StringLength(30, ErrorMessage = "Email must be between 3 and 30 characters long.", MinimumLength = 3)]
        [RegularExpression(@"^[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$", ErrorMessage = "Invalid Email.")]
        public string Email
        {
            get => _email;
            set => _email = value?.Trim();
        }
    }
}
