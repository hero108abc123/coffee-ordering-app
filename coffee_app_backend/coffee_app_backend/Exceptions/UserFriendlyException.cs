namespace coffee_app_backend.Exceptions
{
    public class UserFriendlyException : Exception
    {
        public UserFriendlyException(string message) : base(message) { }
    }
}
