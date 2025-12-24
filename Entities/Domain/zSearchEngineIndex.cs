using System;

namespace Entities
{
    public class zSearchEngineIndex: IEntity
    {
        public zSearchEngineIndex(): base("zSearchEngineIndex")
        {
 
        }

         public int id {get; set;}
         public string BeforeLink {get; set;}
         public string RedirectLink {get; set;}
         public int? isDeleted {get; set;}
         public int? Approved {get; set;}
         public int? CreatedUser {get; set;}
         public int? UpdatedUser {get; set;}
         public DateTime? CreatedDate {get; set;}
         public DateTime? UpdatedDate {get; set;}
 
        public bool _hasTwin { get{ return false; } }
        public bool _hasIdentity { get{ return true; } }
        
        //---------------------------------------------------------
        public static string tableName = "zSearchEngineIndex";
        public string _tableName = "zSearchEngineIndex";

    }
}

