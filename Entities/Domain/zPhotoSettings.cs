using System;

namespace Entities
{
    public class zPhotoSettings: IEntity
    {
        public zPhotoSettings(): base("zPhotoSettings")
        {
 
        }

         public int id {get; set;}
         public string Title {get; set;}
         public int? PageTypeID {get; set;}
         public int? CatID {get; set;}
         public int? RecordID {get; set;}
         public int? ThumbnailWidth {get; set;}
         public int? ThumbnailHeight {get; set;}
         public int? BigImageWidth {get; set;}
         public int? BigImageHeight {get; set;}
         public int? isDeleted {get; set;}
         public int? Approved {get; set;}
         public int? CreatedUser {get; set;}
         public int? UpdatedUser {get; set;}
         public DateTime? CreatedDate {get; set;}
         public DateTime? UpdatedDate {get; set;}
 
        public bool _hasTwin { get{ return false; } }
        public bool _hasIdentity { get{ return true; } }
        
        //---------------------------------------------------------
        public static string tableName = "zPhotoSettings";
        public string _tableName = "zPhotoSettings";

    }
}

