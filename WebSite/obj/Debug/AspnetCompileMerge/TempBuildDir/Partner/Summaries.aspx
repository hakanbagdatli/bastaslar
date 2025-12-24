<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Summaries.aspx.cs" Inherits="WebSite.Partner.Summaries" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

                <!-- header -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-header flex-wrap py-3">
                        <div class="card-title">
                            <div class="d-block text-muted pt-2 font-size-sm">
                                <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                                    <li class="breadcrumb-item"><a href="/partner/" class="text-muted"><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= Language.GetPartner("PotansiyelMusteri") %></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-toolbar">
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <% if (Request["dhx"] == null) { %>
                                <a href="?dhx=add" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetPartner("YeniKayit") %></a>
                                <% } else { %>
                                <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetPartner("Kaydet") %></a>
                                <% } %>
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetPartner("GeriDon") %></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- body -->
                <div class="card card-custom gutter-b example example-compact">

                    <% if (Request["dhx"] == null)  { %>

                    <!-- body -->
                    <div class="card-body">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">ID</th>
                                    <th><%= Language.GetPartner("GosterimNo") %></th>
                                    <th><%= Language.GetPartner("IlgiliProje") %></th>
                                    <th><%= Language.GetPartner("Musteriler") %></th>
                                    <th><%= Language.GetPartner("OrtalamaButce") %></th>
                                    <th><%= Language.GetPartner("Aciklama") %></th>
                                    <th style="width: 50px;"><%= Language.GetPartner("Sil") %></th>
                                    <th style="width: 50px;"><%= Language.GetPartner("Onay") %></th>
                                    <th style="width: 150px;"><%= Language.GetPartner("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.InspectionSummaries> dList = Bll.InspectionSummaries.Select(0, filter: "", sorting: " id DESC");
                                    foreach (var item in dList) { %>
                                <tr class="list-data" data-id="<%= item.id %>">
                                    <td><%= item.id  %></td>
                                    <td><%= item.InspectionNumber %></td>
                                    <td><%= item._InterestedProject %></td>
                                    <td><%= item._CustomerName %></td>
                                    <td><%= item.ClientBudget %></td>
                                    <td><%= item.Summary %></td>
                                    <td>
                                        <div class="checkbox-list">
                                            <label class="checkbox">
                                                <input id="ckDel<%= item.id %>" name="isDeleted" type="checkbox" class="list-form-data" />
                                                <span></span>
                                            </label>
                                        </div>
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
                                        <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetPartner("Duzenle") %>"><i class="la la-edit"></i></a>
                                        <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetPartner("Sil") %>"><i class="la la-trash"></i></a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <input id="table" class="form-control" type="hidden" value="29" />
                        <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                        <% List<Entities.InspectionSummaries> dList = Bll.InspectionSummaries.Select(RecordID, filter: whereClause); %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Gosterimler") %> *</label>
                            <select id="InspectionNumber" class="form-control form-data form-data-option" 
                                onchange="SelectedChange('InspectionNumber','GetAttendees','CustomerID')" required>
                                <%  List<Entities.Inspections> inspectList = Bll.Inspections.Select(0, filter: " AND Approved=1 AND _SaleExecutiveID=" + UserData.id);
                                    foreach (var items in inspectList) { %>
                                <option value="<%= items.PNRCode %>" <%= RecordID > 0 ? dList[0].InspectionNumber == items.PNRCode ? " selected" : "" : "" %>>
                                    <%= items.PNRCode + " - " + items._AgencyName %></option>
                                <% } %>
                            </select>
                        </div>
                        <% if (Request["dhx"] != "edit")  { %>
                        <div class="form-group">
                            <label>Client <%= Language.GetPartner("Bilgisi") %> *</label>
                            <select id="CustomerID" class="form-control form-data form-data-option"  onchange="SelectedChangetoInput('CustomerID','GetBudget','ClientBudget')" data-value="<%= RecordID > 0 ? dList[0].CustomerID.ToString() : "0" %>" required>
                                <option value="0"><%= Language.GetPartner("LutfenSec") %></option>
                            </select>
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("IlgiliProje") %> *</label>
                            <select id="InterestedProjects" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].InterestedProjects.ToString() : "0" %>" required>
                                <option value="0"><%= Language.GetPartner("LutfenSec") %></option>
                                <% var _idList = Select.MultipleCategoryID(3).Split(',').Select(int.Parse).ToList();
                                    List<Entities.GeneralRecords> projectList = Entities.StaticList.Records.Where(x => (_idList.Contains(x.CatID)) && (x.Approved == 1)).ToList();
                                    foreach (var items in projectList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].InterestedProjects == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("OrtalamaButce") %></label>
                            <div class="input-group">
                                <div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="ClientBudget" class="form-control form-data" type="number" value="<%= RecordID > 0 ? dList[0].ClientBudget : "" %>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Aciklama") %></label>
                            <input id="Summary" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Summary : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Not") %></label>
                            <textarea id="Description" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Description : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Durum") %> *</label>
                             <select id="Statu" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].Statu.ToString() : "1" %>" required>
                                <option value="1">Property View</option>
                                <option value="2">Potential Sale</option>
                             </select>
                        </div>
                    </div>

                    <!-- footer -->
                    <div class="card-footer">
                        <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetPartner("Kaydet") %></a>
                        <a href="javascript:;" class="btn btn-secondary font-weight-bold" onclick="window.history.back()">&nbsp;<%= Language.GetPartner("GeriDon") %></a>
                    </div>

                    <% } %>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>