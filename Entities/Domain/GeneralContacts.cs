using System;

namespace Entities
{
    public class GeneralContacts : IEntity
    {
        public GeneralContacts() : base("GeneralContacts")
        {

        }

        public int id { get; set; }
        public int? CatID { get; set; }
        public string _CategoryName { get; set; }
        public string BranchName { get; set; }
        public string Email { get; set; }
        public string Email2 { get; set; }
        public string Gsm { get; set; }
        public string Phone { get; set; }
        public string Phone2 { get; set; }
        public string Fax { get; set; }
        public string Address { get; set; }
        public string Description { get; set; }
        public string GoogleMap { get; set; }
        public string GoogleMapLink { get; set; }
        public string GoogleCoordinate { get; set; }
        public string GoogleLatitude { get; set; }
        public string GoogleLongitude { get; set; }
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
        public static string tableName = "GeneralContacts";
        public string _tableName = "GeneralContacts";

    }
}

