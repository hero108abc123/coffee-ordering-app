using AutoMapper;
using coffee_app_backend.Dtos.UserDtos;
using coffee_app_backend.Entities;


namespace SoundSpace.Helper
{
    public class MappingProfiles : Profile
    {
        public MappingProfiles()
        {
            CreateMap<User, UserDto>();
            CreateMap<UserDto, User>();
        }
    }
}
