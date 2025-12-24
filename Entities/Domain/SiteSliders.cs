using System;

namespace Entities
{
    public class SiteSliders : IEntity
    {
        public SiteSliders() : base("SiteSliders")
        {

        }

        public int id { get; set; }
        public int? LangID { get; set; }
        public string _Language { get; set; }
        public string Title { get; set; }
        public string Note1 { get; set; }
        public string Note2 { get; set; }
        public string ShortContent { get; set; }
        public string Image { get; set; }
        public string Thumbnail { get; set; }
        public string Link { get; set; }
        public string LinkTitle { get; set; }
        public string VideoLink { get; set; }
        public string OpeningType { get; set; }
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
        public static string tableName = "SiteSliders";
        public string _tableName = "SiteSliders";

    }
}

