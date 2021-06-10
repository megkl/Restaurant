using RestaurantEntities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantData.Repositories
{
    public class RestaurantRepo : RestaurantDataRepo<Restaurant>, IRestaurantRepo
    {
        private readonly IRestaurantData<Restaurant> _restaurantData;
        private readonly RestaurantDbContext _db;
        public RestaurantRepo(RestaurantDbContext db, IRestaurantData<Restaurant> restaurantData) : base (db)
        {
            _restaurantData = restaurantData;
            _db = db;
        }
        

        public void Update(Restaurant restaurant)
        {

            var entry = _db.Entry(restaurant);
            entry.State = EntityState.Modified;
            _db.SaveChanges();

            _restaurantData.Add(restaurant);
        }
    }
}
