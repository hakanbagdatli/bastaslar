using System;

namespace Entities
{
    public class Adwords: IEntity
    {
        public Adwords(): base("Adwords")
        {
 
        }

         public int id {get; set;}
         public string Title {get; set;}
         public string Link {get; set;}
         public string OpeningType {get; set;}
         public string Image {get; set;}
         public string Width {get; set;}
         public string Height {get; set;}
         public string Script {get; set;}
         public string AltTag {get; set;}
         public string TitleTag {get; set;}
         public int? isDeleted {get; set;}
         public int? Approved {get; set;}
         public int? CreatedUser {get; set;}
         public int? UpdatedUser {get; set;}
         public DateTime? CreatedDate {get; set;}
         public DateTime? UpdatedDate {get; set;}
 
        public bool _hasTwin { get{ return false; } }
        public bool _hasIdentity { get{ return true; } }
        
        //---------------------------------------------------------
        public static string tableName = "Adwords";
        public string _tableName = "Adwords";

    }
}

