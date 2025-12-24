using System;

namespace Entities
{
    public class DailyReports : IEntity
    {
        public DailyReports() : base("DailyReports")
        {

        }

        public int id { get; set; }
        public int? ReportID { get; set; }
        public string _ReportName { get; set; }
        public string _ReportTemp { get; set; }
        public string Questions { get; set; }
        public string Answers { get; set; }
        public string Filename { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public string _Username { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "DailyReports";
        public string _tableName = "DailyReports";

    }
}

