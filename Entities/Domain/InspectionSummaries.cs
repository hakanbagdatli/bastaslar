using System;

namespace Entities
{
    public class InspectionSummaries : IEntity
    {
        public InspectionSummaries() : base("InspectionSummaries")
        {

        }

        public int id { get; set; }
        public int? CustomerID { get; set; }
        public string _CustomerName { get; set; }
        public string InspectionNumber { get; set; }
        public string _AgencyName { get; set; }
        public string _SaleExecutiveID { get; set; }
        public int? InterestedProjects { get; set; }
        public string _InterestedProject { get; set; }
        public string Summary { get; set; }
        public string ClientBudget { get; set; }
        public string Description { get; set; }
        public int? Statu { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "InspectionSummaries";
        public string _tableName = "InspectionSummaries";

    }
}

