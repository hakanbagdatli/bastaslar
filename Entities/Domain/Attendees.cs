using System;

namespace Entities
{
    public class Attendees : IEntity
    {
        public Attendees() : base("Attendees")
        {

        }

        public int id { get; set; }
        public string InspectionNumber { get; set; }
        public string _AgencyID { get; set; }
        public string _AgencyName { get; set; }
        public string _SaleExecutiveID { get; set; }
        public string _SaleExecutive { get; set; }
        public string Fullname { get; set; }
        public string Budget { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "Attendees";
        public string _tableName = "Attendees";

    }
}

