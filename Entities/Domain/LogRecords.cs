using System;

namespace Entities
{
    public class LogRecords: IEntity
    {
        public LogRecords(): base("LogRecords")
        {
 
        }

        public int id { get; set; }
        public int TypeID { get; set; }
        public string Description { get; set; }
        public string Datastring { get; set; }
        public string IPNumber { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public string _CreatedUserName { get; set; }
        public string _CreatedUserSurname { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }
        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }
        //---------------------------------------------------------
        public static string tableName = "LogRecords";
        public string _tableName = "LogRecords";

    }
}

