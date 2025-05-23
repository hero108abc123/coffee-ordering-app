using System.ComponentModel.DataAnnotations;

namespace coffee_app_backend.Dtos.UserDtos
{
    public class UpdateUserDto
    {
        private string _userName;
        [StringLength(30, ErrorMessage = "Username must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string UserName
        {
            get => _userName;
            set => _userName = value?.Trim();
        }

        private string _mobileNumber;
        [RegularExpression(@"^(0|\+84)(3[2-9]|5[6|8|9]|7[0|6|7|8|9]|8[1-5]|9[0-9])[0-9]{7}$", ErrorMessage = "Invalid Phone Number.")]
        public string MobileNumber
        {
            get => _mobileNumber;
            set => _mobileNumber = value?.Trim();
        }
        private string _address;
        [StringLength(30, ErrorMessage = "Address must be between 3 and 50 characters long.", MinimumLength = 3)]
        public string Address
        {
            get => _address;
            set => _address = value?.Trim();
        }
    }
}
