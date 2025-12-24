using System;

namespace Entities
{
    public class GeneralVideos : IEntity
    {
        public GeneralVideos() : base("GeneralVideos")
        {

        }

        public int id { get; set; }
        public int? LangID { get; set; }
        public string _Language { get; set; }
        public int? TypeID { get; set; }
        public int? CatID { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public string Thumbnail { get; set; }
        public string VideoUrl { get; set; }
        public string VideoEmbed { get; set; }
        public string ShortContent { get; set; }
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
        public static string tableName = "GeneralVideos";
        public string _tableName = "GeneralVideos";

    }
}

