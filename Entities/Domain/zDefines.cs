using System;

namespace Entities
{
    public class zDefines : IEntity
    {
        public zDefines() : base("zDefines")
        {

        }

        public int id { get; set; }
        public string Title { get; set; }
        public byte? hasSubOptions { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "zDefines";
        public string _tableName = "zDefines";

    }
}

