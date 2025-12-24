using System;

namespace Entities
{
    public class ProjectStatus : IEntity
    {
        public ProjectStatus() : base("ProjectStatus")
        {

        }

        public int id { get; set; }
        public string FileName { get; set; }
        public string FileNameColor { get; set; }
        public string Region { get; set; }
        public string RegionColor { get; set; }
        public string TitleDeed { get; set; }
        public string TitleDeedColor { get; set; }
        public string SidePlan { get; set; }
        public string SidePlanColor { get; set; }
        public string ParcelNo { get; set; }
        public string ParcelNoColor { get; set; }
        public string ArchitecturalProject { get; set; }
        public string ArchitecturalProjectColor { get; set; }
        public string StructuralProject { get; set; }
        public string StructuralProjectColor { get; set; }
        public string ElectricalProject { get; set; }
        public string ElectricalProjectColor { get; set; }
        public string MechanicalProject { get; set; }
        public string MechanicalProjectColor { get; set; }
        public string PlanningPermission { get; set; }
        public string PlanningPermissionColor { get; set; }
        public string EnvironmentalReport { get; set; }
        public string EnvironmentalReportColor { get; set; }
        public string BuildingPermit { get; set; }
        public string BuildingPermitColor { get; set; }
        public string FloorAltitude { get; set; }
        public string FloorAltitudeColor { get; set; }
        public string FinalApproval { get; set; }
        public string FinalApprovalColor { get; set; }
        public string IndividualTitleDeeds { get; set; }
        public string IndividualTitleDeedsColor { get; set; }
        public string FollowedBy { get; set; }
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
        public static string tableName = "ProjectStatus";
        public string _tableName = "ProjectStatus";

    }
}

