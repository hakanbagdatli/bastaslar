using System;

namespace Entities
{
    public class LangRecords : IEntity
    {
        public LangRecords() : base("LangRecords")
        {

        }

        public int id { get; set; }
        public int? LangID { get; set; }
        public int? CatID { get; set; }
        public string _Language { get; set; }
        public string _PageTypeID { get; set; }
        public string Title { get; set; }
        public string AdditionalTitle { get; set; }
        public string MetaTitle { get; set; }
        public string MetaUrl { get; set; }
        public string Description { get; set; }
        public string Keywords { get; set; }
        public string Image { get; set; }
        public string Thumbnail { get; set; }
        public string ShortContent { get; set; }
        public string MainContent { get; set; }
        public string PropertyPaymentPlan { get; set; }
        public string Filename { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "LangRecords";
        public string _tableName = "LangRecords";

    }
}

