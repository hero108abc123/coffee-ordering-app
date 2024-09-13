using coffee_app_backend.Entities;
using Microsoft.EntityFrameworkCore;

namespace coffee_app_backend.Dbcontexts
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }

        public DbSet<User> Users { get; set; }
    }
}
