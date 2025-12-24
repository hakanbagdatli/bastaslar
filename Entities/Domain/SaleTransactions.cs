using System;

namespace Entities
{
    public class SaleTransactions : IEntity
    {
        public SaleTransactions() : base("SaleTransactions")
        {

        }

        public int id { get; set; }
        public int? CatID { get; set; }
        public string Title { get; set; }
        public string Filename { get; set; }
        public string Amount { get; set; }
        public string Currency { get; set; }
        public string ShortContent { get; set; }
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
        public static string tableName = "SaleTransactions";
        public string _tableName = "SaleTransactions";

    }
}

