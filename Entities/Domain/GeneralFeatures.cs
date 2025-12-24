using System;

namespace Entities
{
    public class GeneralFeatures : IEntity
    {
        public GeneralFeatures() : base("GeneralFeatures")
        {

        }

        public int id { get; set; }
        public int? LangID { get; set; }
        public string _Language { get; set; }
        public int? TurID { get; set; }
        public int? CatID { get; set; }
        public string Title { get; set; }
        public string AdditionalTitle { get; set; }
        public string Image { get; set; }
        public string Thumbnail { get; set; }
        public string Filename { get; set; }
        public string Link { get; set; }
        public string ShortContent { get; set; }
        public string MainContent { get; set; }
        public byte? onMainPage { get; set; }
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
        public static string tableName = "GeneralFeatures";
        public string _tableName = "GeneralFeatures";

    }
}

