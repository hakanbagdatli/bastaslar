using System;

namespace Entities
{
    public class AgencyCallbacks : IEntity
    {
        public AgencyCallbacks() : base("AgencyCallbacks")
        {

        }

        public int id { get; set; }
        public int? AgencyID { get; set; }
        public string _AgencyName { get; set; }
        public string CallbackType { get; set; }
        public string Description { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public string _Username { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }
        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "AgencyCallbacks";
        public string _tableName = "AgencyCallbacks";

    }
}