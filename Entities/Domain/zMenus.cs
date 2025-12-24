using System;

namespace Entities
{
    public class zMenus : IEntity
    {
        public zMenus() : base("zMenus")
        {

        }

        public int id { get; set; }
        public int CatID { get; set; }
        public string LangID { get; set; }
        public string _CategoryName { get; set; }
        public string Title { get; set; }
        public string _CategoryIcon { get; set; }
        public string Icon { get; set; }
        public string Link { get; set; }
        public byte? isQuick { get; set; }
        public byte? canDeveloper { get; set; }
        public byte? canAdmin { get; set; }
        public byte? canEditor { get; set; }
        public byte? canSales { get; set; }
        public byte? canAgency { get; set; }
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
        public static string tableName = "zMenus";
        public string _tableName = "zMenus";

    }
}

