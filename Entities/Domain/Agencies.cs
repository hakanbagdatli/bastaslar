using System;

namespace Entities
{
    public class Agencies : IEntity
    {
        public Agencies() : base("Agencies")
        {

        }

        public int id { get; set; }
        public int? CatID { get; set; }
        public int? RelevantID { get; set; }
        public string _RelevantName { get; set; }
        public string _RelevantSurname { get; set; }
        public string _RelevantPhone { get; set; }
        public string _RelevantEmail { get; set; }
        public string _RelevantPhoto { get; set; }
        public string AgencyType { get; set; }
        public string ApplicationType { get; set; }
        public string Title { get; set; }
        public string ContactName { get; set; }
        public string ContactEmail { get; set; }
        public string ContactEmail2 { get; set; }
        public string ContactEmail3 { get; set; }
        public string ContactPhone { get; set; }
        public string ContactPhone2 { get; set; }
        public string Address { get; set; }
        public string Province { get; set; }
        public string Country { get; set; }
        public string AgreementFile { get; set; }
        public string AgreementDate { get; set; }
        public string AgreementExpireDate { get; set; }
        public string OperatingMarket  { get; set; }
        public string IntroducedBy { get; set; }
        public string MsnoPassport { get; set; }
        public string Commission { get; set; }
        public string CompanyLogo { get; set; }
        public string WebSite { get; set; }
        public string Facebook { get; set; }
        public string Twitter { get; set; }
        public string Instagram { get; set; }
        public string Youtube { get; set; }
        public string Linkedin { get; set; }
        public string Statu { get; set; }
        public string Segmentation { get; set; }
        public int? CallbackCount { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "Agencies";
        public string _tableName = "Agencies";

    }
}

