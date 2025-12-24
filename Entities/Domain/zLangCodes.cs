using System;

namespace Entities
{
    public class zLangCodes : IEntity
    {
        public zLangCodes() : base("zLangCodes")
        {

        }

        public int id { get; set; }
        public string Title { get; set; }
        public string Code { get; set; }
        public string Flags { get; set; }
        public string SiteTitle { get; set; }
        public string MetaTitle { get; set; }
        public string MetaDescription { get; set; }
        public string MetaKeywords { get; set; }
        public string AdditionalMetaTags { get; set; }
        public string RobotsTxt { get; set; }
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
        public static string tableName = "zLangCodes";
        public string _tableName = "zLangCodes";

    }
}

