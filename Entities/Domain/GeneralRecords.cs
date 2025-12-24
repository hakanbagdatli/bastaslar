using System;

namespace Entities
{
    public class GeneralRecords : IEntity
    {
        public GeneralRecords() : base("GeneralRecords")
        {

        }

        public int id { get; set; }
        public int CatID { get; set; }
        public string _CategoryName { get; set; }
        public string _PageTypeID { get; set; }
        public string Title { get; set; }
        public string _Title { get; set; }
        public string AdditionalTitle { get; set; }
        public string _AdditionalTitle { get; set; }
        public string MetaTitle { get; set; }
        public string _MetaTitle { get; set; }
        public string MetaUrl { get; set; }
        public string _MetaUrl { get; set; }
        public string Description { get; set; }
        public string _Description { get; set; }
        public string Keywords { get; set; }
        public string _Keywords { get; set; }
        public string Image { get; set; }
        public string _Image { get; set; }
        public string Thumbnail { get; set; }
        public string _Thumbnail { get; set; }
        public string ShortContent { get; set; }
        public string _ShortContent { get; set; }
        public string MainContent { get; set; }
        public string _MainContent { get; set; }
        public byte? ImageStatu { get; set; }
        public string Filename { get; set; }
        public string _Filename { get; set; }
        public string Link { get; set; }
        public string OpeningType { get; set; }
        public string RecordDate { get; set; }
        public int? NewsType { get; set; }
        public int? PropertyType { get; set; }
        public string _PropertyType { get; set; }
        public int? PropertyStatu { get; set; }
        public string _PropertyStatu { get; set; }
        public string _PropertyStatuColor { get; set; }
        public string PropertySize { get; set; }
        public string PropertyFlatTypes { get; set; }
        public string PropertyFlatCount { get; set; }
        public string PropertyVillaCount { get; set; }
        public string PropertyPrice { get; set; }
        public string PropertyStartDate { get; set; }
        public string PropertyEndDate { get; set; }
        public string PropertySocialMedia { get; set; }
        public string PropertyFeatures { get; set; }
        public int PropertyCountry { get; set; }
        public string _PropertyCountry { get; set; }
        public int PropertyProvince { get; set; }
        public string _PropertyProvince { get; set; }
        public string PropertyAddress { get; set; }
        public string PropertyLocation { get; set; }
        public string PropertyVirtualTour { get; set; }
        public string PropertyPaymentPlan { get; set; }
        public string _PropertyPaymentPlan { get; set; }
        public byte? isTopMenu { get; set; }
        public byte? onMainPage { get; set; }
        public byte? DontAppearSiteMap { get; set; }
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
        public static string tableName = "GeneralRecords";
        public string _tableName = "GeneralRecords";

    }
}

