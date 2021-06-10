using RestaurantEntities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantData.Repositories
{
    public interface IRestaurantRepo 
    {
       void Update(Restaurant restaurant);
       
    }
}

