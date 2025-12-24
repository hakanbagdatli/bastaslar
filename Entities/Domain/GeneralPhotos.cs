using System;

namespace Entities
{
    public class GeneralPhotos : IEntity
    {
        public GeneralPhotos() : base("GeneralPhotos")
        {

        }

        public int id { get; set; }
        public int? LangID { get; set; }
        public string _Language { get; set; }
        public int TypeID { get; set; }
        public int? CatID { get; set; }
        public int PropertyID { get; set; }
        public string _PropertyName { get; set; }
        public int Outdoor { get; set; }
        public int Indoor { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public string Thumbnail { get; set; }
        public string Link { get; set; }
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
        public static string tableName = "GeneralPhotos";
        public string _tableName = "GeneralPhotos";

    }
}

