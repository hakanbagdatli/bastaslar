using System;

namespace Entities
{
    public class FormCategories: IEntity
    {
        public FormCategories(): base("FormCategories")
        {
 
        }

         public int id {get; set;}
         public string Title {get; set;}
         public string Email {get; set;}
         public string Image {get; set;}
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
        public static string tableName = "FormCategories";
        public string _tableName = "FormCategories";

    }
}

