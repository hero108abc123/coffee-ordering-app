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

        public DbSet<Category> Categories { get; set; }

        public DbSet<Coffee> Coffees { get; set; }

        public DbSet<Invoice> Invoices { get; set; }

        public DbSet<CartItem> CartItems { get; set; }

        public DbSet<FavoriteCoffee> FavoriteCoffees { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            // Quan hệ Category - Coffee (1 - N)
            modelBuilder.Entity<Coffee>()
                .HasOne(c => c.Category)
                .WithMany(cat => cat.Coffees)
                .HasForeignKey(c => c.CategoryId);

            // Quan hệ User - Invoice (1 - N)
            modelBuilder.Entity<Invoice>()
                .HasOne(i => i.User)
                .WithMany(u => u.Invoices)
                .HasForeignKey(i => i.UserId);

            // Quan hệ nhiều - nhiều giữa Invoice và Coffee thông qua CartItem
            modelBuilder.Entity<CartItem>()
                .HasKey(ci => new { ci.InvoiceId, ci.CoffeeId });

            modelBuilder.Entity<CartItem>()
                .HasOne(ci => ci.Invoice)
                .WithMany(i => i.Coffees)
                .HasForeignKey(ci => ci.InvoiceId);

            modelBuilder.Entity<CartItem>()
                .HasOne(ci => ci.Coffee)
                .WithMany(c => c.Invoices)
                .HasForeignKey(ci => ci.CoffeeId);

            modelBuilder.Entity<FavoriteCoffee>()
                .HasKey(ci => new { ci.UserId, ci.CoffeeId });

            modelBuilder.Entity<FavoriteCoffee>()
                .HasOne(ci => ci.User)
                .WithMany(i => i.Coffees)
                .HasForeignKey(ci => ci.UserId);

            modelBuilder.Entity<FavoriteCoffee>()
                .HasOne(ci => ci.Coffee)
                .WithMany(c => c.Users)
                .HasForeignKey(ci => ci.CoffeeId);

        }
    }
}
