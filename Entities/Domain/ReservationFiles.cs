using System;

namespace Entities
{
    public class ReservationFiles: IEntity
    {
        public ReservationFiles(): base("ReservationFiles")
        {
 
        }

         public int id {get; set;}
         public int? LangID {get; set;}
         public int? TurID {get; set;}
         public int? CatID {get; set;}
         public int? FileTypeID {get; set;}
         public string Title {get; set;}
         public string Filesize {get; set;}
         public string Filename {get; set;}
         public string Thumbnail {get; set;}
         public string ShortContent {get; set;}
         public int? Sorting {get; set;}
         public int? isDeleted {get; set;}
         public int? Approved {get; set;}
         public int? CreatedUser {get; set;}
         public int? UpdatedUser {get; set;}
         public DateTime? CreatedDate {get; set;}
         public DateTime? UpdatedDate {get; set;}
 
        public bool _hasTwin { get{ return false; } }
        public bool _hasIdentity { get{ return true; } }
        
        //---------------------------------------------------------
        public static string tableName = "ReservationFiles";
        public string _tableName = "ReservationFiles";

    }
}

