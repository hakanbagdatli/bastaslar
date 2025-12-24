using System;
using System.Security.Cryptography;

namespace Entities
{
    public class InspectionLeads : IEntity
    {
        public InspectionLeads() : base("InspectionLeads")
        {

        }

        public int id { get; set; }
        public int SalesExecutive { get; set; }
        public string _AssignedSalesExecutive { get; set; }
        public string InspectionNumber { get; set; }
        public string LeadsDate { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Channel { get; set; }
        public string AdvInformation { get; set; }
        public string Call { get; set; }
        public string Occupation { get; set; }
        public string Age { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string Budget { get; set; }
        public string InterestedProperty { get; set; }
        public string Message { get; set; }
        public string Notes { get; set; }
        public string isInterested { get; set; }
        public string Result { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "InspectionLeads";
        public string _tableName = "InspectionLeads";

    }
}

