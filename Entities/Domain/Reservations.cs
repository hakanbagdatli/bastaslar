using System;

namespace Entities
{
    public class Reservations : IEntity
    {
        public Reservations() : base("Reservations")
        {

        }

        public int id { get; set; }
        public int? TurID { get; set; }
        public int AgencyID { get; set; }
        public string _AgencyName { get; set; }
        public string _SaleExecutiveID { get; set; }
        public string _SaleExecutive { get; set; }
        public int? ProjectID { get; set; }
        public string _ProjectName { get; set; }
        public string InspectionNumber { get; set; }
        public string _InspectionNumber { get; set; }
        public string SummaryNumber { get; set; }
        public string ReservationNumber { get; set; }
        public string SaleNumber { get; set; }
        public int? PlanID { get; set; }
        public string _PlanName { get; set; }
        public int? CustomerID { get; set; }
        public string _CustomerName { get; set; }
        public string _CustomerSurname { get; set; }
        public string _CustomerEmail { get; set; }
        public string _CustomerPhone { get; set; }
        public string _CustomerLawyer { get; set; }
        public string _CustomerCountry { get; set; }
        public string ShortContent { get; set; }
        public string ReservationDate { get; set; }
        public string ContractofSigning { get; set; }
        public string ListPrice { get; set; }
        public string Discount { get; set; }
        public string SalePrice { get; set; }
        public string AgencyDiscount { get; set; }
        public string AgencyCommission { get; set; }
        public string ContractPrice { get; set; }
        public string Currency { get; set; }
        public byte? isDepositPaid { get; set; }
        public byte? isReservationApproved { get; set; }
        public byte? hasLegalInfoProvided { get; set; }
        public byte? isDraftContractApproved { get; set; }
        public byte? isSendLawyer { get; set; }
        public byte? hasDownPayment { get; set; }
        public byte? isClientApproved { get; set; }
        public byte? isDirectorApproved { get; set; }
        public byte? isStamped { get; set; }
        public byte? isProcessStart { get; set; }
        public byte? isSendedAgent { get; set; }
        public byte? isAgencyConfirmed { get; set; }
        public byte? isSendedFinance { get; set; }
        public byte? isCommissionPaid { get; set; }
        public int? Statu { get; set; }
        public string _Statu { get; set; }
        public string _StatuColor { get; set; }
        public int? isDeleted { get; set; }
        public int? Approved { get; set; }
        public int? CreatedUser { get; set; }
        public int? UpdatedUser { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public bool _hasTwin { get { return false; } }
        public bool _hasIdentity { get { return true; } }

        //---------------------------------------------------------
        public static string tableName = "Reservations";
        public string _tableName = "Reservations";

    }
}

