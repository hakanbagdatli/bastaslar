using System.Collections.Generic;
using System.Web;

namespace Entities.Items
{
    public class Property
    {
        public string id { get; set; }
        public string type { get; set; }
        public string name { get; set; }
        public string value { get; set; }
    }

    public class RootData
    {
        public int id { get; set; }
        public int type { get; set; }
        public List<Property> properties { get; set; }
    }

}
