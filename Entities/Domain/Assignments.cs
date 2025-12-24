using System;
using System.Collections.Generic;

namespace Entities
{
    public class Assignments : IEntity
    {
        public Assignments() : base("Assignments")
        {

        }

        public int id { get; set; }
        public string Title { get; set; }
        public string UserID { get; set; }
        public List<Entities.zUsers> _Users { get; set; }
        public string TaskDate { get; set; }
        public string TaskTime { get; set; }
        public string Description { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }
        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "Assignments";
        public string _tableName = "Assignments";

    }
}

