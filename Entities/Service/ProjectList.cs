using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities.Service
{
    public class ProjectList
    {
        public int id { get; set; }
        public string Project { get; set; }
        public string Title { get; set; }
        public string Photo { get; set; }
        public string ShortContent { get; set; }
        public string MainContent { get; set; }
        public string PropertyType { get; set; }
        public string PropertyStatu { get; set; }
        public string PropertySize { get; set; }
        public string PropertyFlatCount { get; set; }
        public string PropertyStartDate { get; set; }
        public string PropertyEndDate { get; set; }
        public string PropertyProvince { get; set; }
        public List<PropertyList> Properties { get; set; }
    }

    public class PropertyList
    {

        public int id { get; set; }
        public string Title { get; set; }
        public string ShortContent { get; set; }
        public string MainContent { get; set; }
        public string Photo { get; set; }
        public string PropertyID { get; set; }
        public string Property3ID { get; set; }
        public string PropertyUnitType { get; set; }
        public string PropertyPrice { get; set; }
        public string PropertySize { get; set; }
        public int PropertyBath { get; set; }
        public int PropertyBedroom { get; set; }
        public string PropertyVirtualTour { get; set; }
        public string PropertyStatus { get; set; }
    }
}
