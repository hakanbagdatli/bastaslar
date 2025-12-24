using System;

namespace Entities
{
    public class zDefineDetails : IEntity
    {
        public zDefineDetails() : base("zDefineDetails")
        {

        }

        public int id { get; set; }
        public int CatID { get; set; }
        public byte? _hasSubOptions { get; set; }
        public int? DefineID { get; set; }
        public string Title { get; set; }
        public string Amount { get; set; }
        public string Description { get; set; }
        public int? FileTypeID { get; set; }
        public string Filename { get; set; }
        public string Icon { get; set; }
        public string Color { get; set; }
        public int? forSales { get; set; }
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
        public static string tableName = "zDefineDetails";
        public string _tableName = "zDefineDetails";

    }
}

