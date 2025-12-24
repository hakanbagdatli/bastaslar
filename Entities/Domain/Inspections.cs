using System;
using System.Collections.Generic;

namespace Entities
{
    public class Inspections : IEntity
    {
        public Inspections() : base("Inspections")
        {

        }

        public int id { get; set; }
        public int? TurID { get; set; }
        public int? AgencyID { get; set; }
        public int? MeetingRoomID { get; set; }
        public string _MeetingRoom { get; set; }
        public string _AgencyName { get; set; }
        public string _SaleExecutiveID { get; set; }
        public string _SaleExecutive { get; set; }
        public string AttendingAgentPersonal { get; set; }
        public string PropertyViewType { get; set; }
        public string PNRCode { get; set; }
        public string ProjectID { get; set; }
        public List<Entities.GeneralRecords> _Projects { get; set; }
        public string CheckinDate { get; set; }
        public string CheckinTime { get; set; }
        public string CheckoutDate { get; set; }
        public string CheckoutTime { get; set; }
        public int? Presenter { get; set; }
        public string _PresenterName { get; set; }
        public string PrePresentationDate { get; set; }
        public string PrePresentationTime { get; set; }
        public string PresentationDate { get; set; }
        public string PresentationTime { get; set; }
        public int? AdultCount { get; set; }
        public string Clients { get; set; }
        public string Nationality { get; set; }
        public string Occupation { get; set; }
        public int? PurposeThePurchase { get; set; }
        public int? InterestedPropertyType { get; set; }
        public string SpecificAmenities { get; set; }
        public int? ProjectPhase { get; set; }
        public string ClientsBudget { get; set; }
        public string ContactNo1 { get; set; }
        public string ContactNo2 { get; set; }
        public string Passports { get; set; }
        public int? ChildCount { get; set; }
        public byte? hasChild { get; set; }
        public string ChildrenInformation { get; set; }
        public byte? hasArrivalTransfer { get; set; }
        public string ArrivalAirport { get; set; }
        public string ArrivalFlightNumber { get; set; }
        public string ArrivalDate { get; set; }
        public string ArrivalTime { get; set; }
        public byte? hasDepartureTransfer { get; set; }
        public string DepartureAirport { get; set; }
        public string DepartureFlightNumber { get; set; }
        public string DepartureDate { get; set; }
        public string DepartureTime { get; set; }
        public string PreferredLanguage { get; set; }
        public string Message { get; set; }
        public byte? isScheduleCompleted { get; set; }
        public byte? isPresentationCompleted { get; set; }
        public byte? hasLaunch { get; set; }
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
        public static string tableName = "Inspections";
        public string _tableName = "Inspections";

    }
}

