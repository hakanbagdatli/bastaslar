<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Status.aspx.cs" Inherits="WebSite.Partner.Status" %>

<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-status td {
            min-width: 120px;
            text-align: center;
            align-items: center;
            align-content: center;
            border: 1px solid #EBEDF3;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="39" />
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">

                <!-- header -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-header flex-wrap py-3">
                        <div class="card-title">
                            <div class="d-block text-muted pt-2 font-size-sm">
                                <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                                    <li class="breadcrumb-item"><a href="/partner/" class="text-muted"><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= Language.GetPartner("ProjeDurumlari") %></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-toolbar">
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetPartner("GeriDon") %></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- body -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-body" style="overflow-x:auto">
                        <table class="table table-separate table-head-custom table-checkable table-status" id="liophinTable">
                            <thead>
                                <tr>
                                    <th>File Name</th>
                                    <th>Region</th>
                                    <th>Title Deed</th>
                                    <th>Side Plan</th>
                                    <th>Parcel No</th>
                                    <th>Architectural Project</th>
                                    <th>Structural Project and Report</th>
                                    <th>Electrical Project</th>
                                    <th>Mechanical Project</th>
                                    <th>Planning Permission</th>
                                    <th>Environmental Report</th>
                                    <th>Building Permit</th>
                                    <th>Kat İrtifak Title Deeds</th>
                                    <th>Final Approval</th>
                                    <th>Individual Title Deeds</th>
                                    <th>Followed By</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.ProjectStatus> dList = Bll.ProjectStatus.Select(0, filter: " AND Approved=1", sorting: " Sorting ASC, id DESC");
                                    foreach (var item in dList)
                                    { %>
                                <tr class="list-data" data-id="<%= item.id %>">
                                    <td style="background: <%= item.FileNameColor %>"><%= item.FileName %></td>
                                    <td style="background: <%= item.RegionColor %>"><%= item.Region %></td>
                                    <td style="background: <%= item.TitleDeedColor %>"><%= item.TitleDeed %></td>
                                    <td style="background: <%= item.SidePlanColor %>"><%= item.SidePlan %></td>
                                    <td style="background: <%= item.ParcelNoColor %>"><%= item.ParcelNo %></td>
                                    <td style="background: <%= item.ArchitecturalProjectColor %>"><%= item.ArchitecturalProject %></td>
                                    <td style="background: <%= item.StructuralProjectColor %>"><%= item.StructuralProject %></td>
                                    <td style="background: <%= item.ElectricalProjectColor %>"><%= item.ElectricalProject %></td>
                                    <td style="background: <%= item.MechanicalProjectColor %>"><%= item.MechanicalProject %></td>
                                    <td style="background: <%= item.PlanningPermissionColor %>"><%= item.PlanningPermission %></td>
                                    <td style="background: <%= item.EnvironmentalReportColor %>"><%= item.EnvironmentalReport %></td>
                                    <td style="background: <%= item.BuildingPermitColor %>"><%= item.BuildingPermit %></td>
                                    <td style="background: <%= item.FloorAltitudeColor %>"><%= item.FloorAltitude %></td>
                                    <td style="background: <%= item.FinalApprovalColor %>"><%= item.FinalApproval %></td>
                                    <td style="background: <%= item.IndividualTitleDeedsColor %>"><%= item.IndividualTitleDeeds %></td>
                                    <td><%= item.FollowedBy %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script src="/raven/assets/vendors/page.daily.js?v=<%= Feature.Version %>"></script>
</asp:Content>
