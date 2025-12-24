using System;

namespace Entities
{
    public class LangFixed : IEntity
    {
        public LangFixed() : base("LangFixed")
        {

        }

        public int id { get; set; }
        public string LangTR { get; set; }
        public string LangEN { get; set; }
        public string LangAR { get; set; }
        public string LangDE { get; set; }
        public string LangFR { get; set; }
        public string LangRU { get; set; }
        public string LangJA { get; set; }
        public string LangZH { get; set; }
        public string LangIT { get; set; }
        public string LangPT { get; set; }
        public string LangES { get; set; }
        public string LangFA { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "LangFixed";
        public string _tableName = "LangFixed";

    }
}

