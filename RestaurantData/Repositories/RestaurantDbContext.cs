using RestaurantEntities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantData.Repositories
{
    public class RestaurantDbContext : DbContext, IDbContext
    { 
    public RestaurantDbContext() : base("RestaurantsEntities")
    {
    }

    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    {
        //base.OnModelCreating(modelBuilder);
    }

    public IDbSet<TEntity> Set<TEntity>() where TEntity : class
    {
        return base.Set<TEntity>();
    }

    public DbSet<Restaurant> Restaurants { get; set; }
}
}