using System;

namespace Entities
{
    public class zUsersStatu : IEntity
    {
        public zUsersStatu() : base("zUsersStatu")
        {

        }

        public int id { get; set; }
        public string Title { get; set; }
        public byte? Developer { get; set; }
        public byte? Admin { get; set; }
        public byte? Editor { get; set; }
        public byte? Sales { get; set; }
        public byte? Agency { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "zUsersStatu";
        public string _tableName = "zUsersStatu";

    }
}

