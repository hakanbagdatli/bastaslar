using System;

namespace Entities
{
    public class zPageTypes: IEntity
    {
        public zPageTypes(): base("zPageTypes")
        {
 
        }

         public int id {get; set;}
         public string Title {get; set;}
         public string ConstantURL {get; set;}
         public string ListingPage {get; set;}
         public string DetailPage {get; set;}
         public string AdminUrl {get; set;}
         public byte? isContentFixed {get; set;}
         public byte? isDetailSingle {get; set;}
         public byte? isDirectList {get; set;}
         public byte? isRecord {get; set;}
         public byte? isContact {get; set;}
         public byte? isLinkFreeRecord {get; set;}
         public byte? isLinkFreeCategory {get; set;}
         public byte? PagingStatus {get; set;}
         public byte? DontAppearSiteMap {get; set;}
         public int? NumberofListings {get; set;}
         public int? isDeleted {get; set;}
         public int? Approved {get; set;}
         public int? CreatedUser {get; set;}
         public int? UpdatedUser {get; set;}
         public DateTime? CreatedDate {get; set;}
         public DateTime? UpdatedDate {get; set;}
 
        public bool _hasTwin { get{ return false; } }
        public bool _hasIdentity { get{ return true; } }
        
        //---------------------------------------------------------
        public static string tableName = "zPageTypes";
        public string _tableName = "zPageTypes";

    }
}

