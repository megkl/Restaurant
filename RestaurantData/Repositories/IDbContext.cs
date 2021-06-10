using System.Data.Entity;

namespace RestaurantData.Repositories
{
    public interface IDbContext
    {
        IDbSet<TEntity> Set<TEntity>() where TEntity : class;
        int SaveChanges();
    }
}