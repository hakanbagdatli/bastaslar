using System;

namespace Entities
{
    public class FormIncomings : IEntity
    {
        public FormIncomings() : base("FormIncomings")
        {

        }

        public int id { get; set; }
        public int? CatID { get; set; }
        public string _CategoryName { get; set; }
        public string Number { get; set; }
        public string IdentityNo { get; set; }
        public string NameSurname { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public string AdditionalData1 { get; set; }
        public string AdditionalData2 { get; set; }
        public string AdditionalData3 { get; set; }
        public string AdditionalData4 { get; set; }
        public string AdditionalData5 { get; set; }
        public string FullContent { get; set; }
        public string IPNumber { get; set; }
        public byte? isArchive { get; set; }
        public byte? isReaded { get; set; }
        public DateTime? ArchiveDate { get; set; }
        public DateTime? ReadedDate { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "FormIncomings";
        public string _tableName = "FormIncomings";

    }
}

