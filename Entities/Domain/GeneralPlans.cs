using System;

namespace Entities
{
    public class GeneralPlans : IEntity
    {
        public GeneralPlans() : base("GeneralPlans")
        {

        }

        public int id { get; set; }
        public int? LangID { get; set; }
        public string _Language { get; set; }
        public int? TurID { get; set; }
        public int? CatID { get; set; }
        public string _CategoryName { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public string Thumbnail { get; set; }
        public string Filename { get; set; }
        public string FilenameTR { get; set; }
        public string VideoEmbed { get; set; }
        public string Link { get; set; }
        public string MainContent { get; set; }
        public string ShortContent { get; set; }
        public string PropertyID { get; set; }
        public string PropertyFloor { get; set; }
        public string Property3ID { get; set; }
        public string PropertyUnitType { get; set; }
        public string PropertyPrice { get; set; }
        public string PropertySize { get; set; }
        public string PropertyLandArea { get; set; }
        public string PropertyGarageArea { get; set; }
        public string PropertyPoolArea { get; set; }
        public string PropertyGrossArea { get; set; }
        public string PropertyTerraceArea { get; set; }
        public string PropertyOpenTerrace { get; set; }
        public string PropertyRoofTerrace { get; set; }
        public int PropertyBath { get; set; }
        public int PropertyBedroom { get; set; }
        public string PropertyVirtualTour { get; set; }
        public string PropertyStatus { get; set; }
        public int? Sorting { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "GeneralPlans";
        public string _tableName = "GeneralPlans";

    }
}

