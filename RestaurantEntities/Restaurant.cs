using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantEntities
{
    [DataContract]
    public class Restaurant
    {
        [DataMember]
        public string Id { get; set; }

        [DataMember]
        public string Name { get; set; }

    }
}
