using System;

namespace Entities
{
    public class Customers : IEntity
    {
        public Customers() : base("Customers")
        {

        }

        public int id { get; set; }
        public int? AgencyID { get; set; }
        public string _AgencyName { get; set; }
        public string _SaleExecutiveID { get; set; }
        public string _SaleExecutive { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public int? Gender { get; set; }
        public string Birthday { get; set; }
        public string PassportNo { get; set; }
        public string Occupation { get; set; }
        public string WorkAddres { get; set; }
        public string Lawyer { get; set; }
        public string Country { get; set; }
        public string ShortContent { get; set; }
        public string Image { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "Customers";
        public string _tableName = "Customers";

    }
}

