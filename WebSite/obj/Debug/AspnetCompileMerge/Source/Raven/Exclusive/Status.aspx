<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Status.aspx.cs" Inherits="WebSite.Raven.Exclusive.Status" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="42" />
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card card-custom gutter-b example example-compact">

                    <!-- header -->
                    <div class="card-header flex-wrap py-3">
                        <div class="card-title">
                            <div class="d-block text-muted pt-2 font-size-sm">
                                <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                                    <asp:Literal ID="ltrTree" runat="server" />
                                </ul>
                            </div>
                        </div>
                        <div class="card-toolbar">
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <% if (Request["dhx"] == null) { %>
                                <a href="?dhx=add" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
                                <a href="?dhx=all" class="btn btn-secondary font-weight-bold"><i class="la la-file-excel-o"></i>&nbsp;<%= Language.GetFixed("TumunuGor") %></a>
                                <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("ListeGuncelle") %></a>
                                <% } else { %>
                                <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                                <% } %>
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                            </div>
                        </div>
                    </div>

                    <% if (Request["dhx"] == null) { %>
                    
                    <!-- body -->
                    <div class="card-body">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">ID</th>
                                    <th>File Name</th>
                                    <th>Region</th>
                                    <th>Final Approval</th>
                                    <th>Followed By</th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                    <th style="width: 150px;"><%= Language.GetFixed("Tarih") %></th>
                                    <th style="width: 100px;"><%= Language.GetFixed("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.ProjectStatus> dList = Bll.ProjectStatus.Select(0, filter: "", sorting: " Sorting ASC, id DESC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.FileName %></td>
                                        <td><%= item.Region %></td>
                                        <td><%= item.FinalApproval %></td>
                                        <td><%= item.FollowedBy %></td>
                                        <td>
                                            <input id="txtSort<%= item.id %>" name="Sorting" type="text" class="form-control list-form-data center" autocomplete="off" value="<%= item.Sorting %>" />
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckApp<%= item.id %>" name="Approved" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Approved) ? "checked" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckDel<%= item.id %>" name="isDeleted" type="checkbox" class="list-form-data" />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td><%= !String.IsNullOrEmpty(item.UpdatedDate.ToString()) ? Helper.DateFormat(item.UpdatedDate.ToString()) : Helper.DateFormat(item.CreatedDate.ToString()) %></td>
                                        <td>
                                            <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Duzenle") %>"><i class="la la-edit"></i></a>
                                            <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Sil") %>"><i class="la la-trash"></i></a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else if (Request["dhx"] == "all") { %>
                    
                    <!-- body -->
                    <div class="card-body">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">ID</th>
                                    <th>File Name</th>
                                    <th>Region</th>
                                    <th>Final Approval</th>
                                    <th>Followed By</th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                    <th style="width: 150px;"><%= Language.GetFixed("Tarih") %></th>
                                    <th style="width: 200px;"><%= Language.GetFixed("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.ProjectStatus> dList = Bll.ProjectStatus.Select(0, filter: "", sorting: " Sorting ASC, id DESC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.FileName %></td>
                                        <td><%= item.Region %></td>
                                        <td><%= item.FinalApproval %></td>
                                        <td><%= item.FollowedBy %></td>
                                        <td>
                                            <input id="txtSort<%= item.id %>" name="Sorting" type="text" class="form-control list-form-data center" autocomplete="off" value="<%= item.Sorting %>" />
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckApp<%= item.id %>" name="Approved" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Approved) ? "checked" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckDel<%= item.id %>" name="isDeleted" type="checkbox" class="list-form-data" />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td><%= !String.IsNullOrEmpty(item.UpdatedDate.ToString()) ? Helper.DateFormat(item.UpdatedDate.ToString()) : Helper.DateFormat(item.CreatedDate.ToString()) %></td>
                                        <td>
                                            <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Duzenle") %>"><i class="la la-edit"></i></a>
                                            <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Sil") %>"><i class="la la-trash"></i></a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                        <% List<Entities.ProjectStatus> dList = Bll.ProjectStatus.Select(RecordID, filter: ""); %>
                        <div class="form-group">
                            <label>File Name *</label>
                            <div class="input-group">
                                <input id="FileName" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].FileName : "" %>" required />
							    <div class="input-group-append">
								    <select id="FileNameColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].FileNameColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].FileNameColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
								    </select>
							    </div>
							</div>
                        </div>
                        <div class="form-group">
                            <label>Region *</label>
                            <div class="input-group">
                                <input id="Region" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Region : "" %>" required />
							    <div class="input-group-append">
								    <select id="RegionColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].RegionColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].RegionColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
								    </select>
							    </div>
						    </div>
                        </div>
                        <div class="form-group">
                            <label>Title Deed</label>
                            <div class="input-group">
                                <input id="TitleDeed" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].TitleDeed : "" %>" />
							    <div class="input-group-append">
								    <select id="TitleDeedColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].TitleDeedColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].TitleDeedColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
								    </select>
							    </div>
							</div>
                        </div>
                        <div class="form-group">
                            <label>Side Plan</label>
                            <div class="input-group">
                                <input id="SidePlan" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].SidePlan : "" %>" />
							    <div class="input-group-append">
				                    <select id="SidePlanColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].SidePlanColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].SidePlanColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
				                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Parcel No</label>
                            <div class="input-group">
                                <textarea id="ParcelNo" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ParcelNo : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="ParcelNoColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].ParcelNoColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].ParcelNoColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Architectural Project</label>
                            <div class="input-group">
                                <textarea id="ArchitecturalProject" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ArchitecturalProject : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="ArchitecturalProjectColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].ArchitecturalProjectColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].ArchitecturalProjectColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Structural Project and Report</label>
                            <div class="input-group">
                                <textarea id="StructuralProject" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].StructuralProject : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="StructuralProjectColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].StructuralProjectColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].StructuralProjectColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Electrical Project</label>
                            <div class="input-group">
                                <textarea id="ElectricalProject" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ElectricalProject : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="ElectricalProjectColor" class="form-control form-data form-data-option" type="option"
                                        data-value="<%= RecordID > 0 ? dList[0].ElectricalProjectColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].ElectricalProjectColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Mechanical Project</label>
                            <div class="input-group">
                                <textarea id="MechanicalProject" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].MechanicalProject : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="MechanicalProjectColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].MechanicalProjectColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].MechanicalProjectColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Planning Permission</label>
                            <div class="input-group">
                                <textarea id="PlanningPermission" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].PlanningPermission : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="PlanningPermissionColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].PlanningPermissionColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].PlanningPermissionColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Environmental Report</label>
                            <div class="input-group">
                                <textarea id="EnvironmentalReport" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].EnvironmentalReport : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="EnvironmentalReportColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].EnvironmentalReportColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].EnvironmentalReportColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Building Permit</label>
                            <div class="input-group">
                                <textarea id="BuildingPermit" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].BuildingPermit : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="BuildingPermitColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].BuildingPermitColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].BuildingPermitColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Kat İrtifak Title Deeds</label>
                            <div class="input-group">
                                <textarea id="FloorAltitude" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].FloorAltitude : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="FloorAltitudeColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].FloorAltitudeColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].FloorAltitudeColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Final Approval</label>
                            <div class="input-group">
                                <textarea id="FinalApproval" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].FinalApproval : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="FinalApprovalColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].FinalApprovalColor : "#FFFFFF" %>"
                                        style="background:<%= RecordID > 0 ? dList[0].FinalApprovalColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Individual Title Deeds</label>
                            <div class="input-group">
                                <textarea id="IndividualTitleDeeds" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].IndividualTitleDeeds : "" %></textarea>
							    <div class="input-group-append">
                                    <select id="IndividualTitleDeedsColor" class="form-control form-data form-data-option" type="option" 
                                        data-value="<%= RecordID > 0 ? dList[0].IndividualTitleDeedsColor : "#FFFFFF" %>" 
                                        style="background:<%= RecordID > 0 ? dList[0].IndividualTitleDeedsColor : "#FFFFFF" %>">
                                        <option value="#FFFFFF">Renk Yok</option>
                                        <option value="#FF0000">Kırmızı</option>
                                        <option value="#FF7F00">Turuncu</option>
                                        <option value="#FFFF00">Sarı</option>
                                        <option value="#00FF00">Yeşil</option>
                                        <option value="#0000FF">Mavi</option>
                                        <option value="#4B0082">Lacivert</option>
                                        <option value="#8B00FF">Mor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Followed By</label>
                            <input id="FollowedBy" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].FollowedBy : "" %>" />
                        </div>
                    </div>

                    <!-- footer -->
                    <div class="card-footer">
                        <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                        <a href="javascript:;" class="btn btn-secondary font-weight-bold" onclick="window.history.back()">&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                    </div>

                    <% } %>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script src="/raven/assets/vendors/app.calback.js?v<%= Utility.Feature.Version %>"></script>
</asp:Content>