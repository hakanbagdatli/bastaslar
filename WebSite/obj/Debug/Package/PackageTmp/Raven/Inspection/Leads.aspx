<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Leads.aspx.cs" Inherits="WebSite.Raven.Inspection.Leads" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="41" />
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
                                <a href="?dhx=add&catid=<%= CatID %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
                                <a href="?dhx=all" class="btn btn-secondary font-weight-bold"><i class="la la-file-excel-o"></i>&nbsp;<%= Language.GetFixed("TumunuGor") %></a>
                                <a href="?dhx=excel"class="btn btn-import-excel btn-secondary font-weight-bold"><i class="la la-file-excel-o"></i>&nbsp;Import Excel List</a>
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
                                    <th>ID</th>
                                    <th>Assigned Sales Executive</th>
                                    <th><%= Language.GetFixed("AdSoyad") %></th>
                                    <th><%= Language.GetFixed("Telefon") %></th>
                                    <th><%= Language.GetFixed("Email") %></th>
                                    <th>Lead Channel</th>
                                    <th>Adv. Info</th>
                                    <th><%= Language.GetFixed("Butce") %></th>
                                    <th><%= Language.GetFixed("Sehir") %></th>
                                    <th>Leads Date</th>
                                    <th>Result</th>
                                    <th>Updated Date</th>
                                    <th style="width:100px"><%= Language.GetFixed("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.InspectionLeads> dList = Bll.InspectionLeads.Select(0, filter: whereClause, sorting : " id DESC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item._AssignedSalesExecutive %></td>
                                        <td><%= item.Name + " " + item.Surname %></td>
                                        <td><%= item.Phone %></td>
                                        <td><%= item.Email %></td>
                                        <td><%= item.Channel %></td>
                                        <td><%= item.AdvInformation %></td>
                                        <td><%= item.Budget %></td>
                                        <td><%= item.City %></td>
                                        <td><%= Utility.Helper.DatewithCulture(item.LeadsDate, "1") %></td>
                                        <td><%= item.Result %></td>
                                        <td><%= item.UpdatedUser > 0 ? Utility.Helper.DateFormat(item.UpdatedDate.ToString()) : Utility.Helper.DateFormat(item.CreatedDate.ToString()) %></td>
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
                                    <th>ID</th>
                                    <th>Assigned Sales Executive</th>
                                    <th><%= Language.GetFixed("AdSoyad") %></th>
                                    <th><%= Language.GetFixed("Telefon") %></th>
                                    <th><%= Language.GetFixed("Email") %></th>
                                    <th>Lead Channel</th>
                                    <th>Adv. Info</th>
                                    <th>Call</th>
                                    <th><%= Language.GetFixed("Meslek") %></th>
                                    <th>Age</th>
                                    <th><%= Language.GetFixed("Ulke") %></th>
                                    <th><%= Language.GetFixed("Sehir") %></th>
                                    <th><%= Language.GetFixed("Butce") %></th>
                                    <th>Interested Property</th>
                                    <th>Message</th>
                                    <th>Notes</th>
                                    <th>Leads Date</th>
                                    <th>Is Interested</th>
                                    <th>Result</th>
                                    <th>Updated Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.InspectionLeads> dList = Bll.InspectionLeads.Select(0, filter: whereClause, sorting : " id DESC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item._AssignedSalesExecutive %></td>
                                        <td><%= item.Name + " " + item.Surname %></td>
                                        <td><%= item.Phone %></td>
                                        <td><%= item.Email %></td>
                                        <td><%= item.Channel %></td>
                                        <td><%= item.AdvInformation %></td>
                                        <td><%= item.Call %></td>
                                        <td><%= item.Occupation %></td>
                                        <td><%= item.Age %></td>
                                        <td><%= item.Country %></td>
                                        <td><%= item.City %></td>
                                        <td><%= item.Budget %></td>
                                        <td><%= item.InterestedProperty %></td>
                                        <td><%= item.Message %></td>
                                        <td><%= item.Notes %></td>
                                        <td><%= Utility.Helper.DatewithCulture(item.LeadsDate, "1") %></td>
                                        <td><%= item.isInterested %></td>
                                        <td><%= item.Result %></td>
                                        <td><%= item.UpdatedUser > 0 ? Utility.Helper.DateFormat(item.UpdatedDate.ToString()) : Utility.Helper.DateFormat(item.CreatedDate.ToString()) %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else if (Request["dhx"] == "excel") { %>
                    
                    <!-- body -->
                    <div class="card-body">
                        <div class="m-portlet__body">
                            <div class="form-group">
                                <label class="mb-5">Excel Data List</label>
                                <div class="custom-file">
                                    <input id="ExcelList" class="custom-file-input form-data" type="file" data-crop="false" data-path="files" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <label class="mt-5">Download example excel file <a href="<%= Utility.Feature.FileFolder + "example-leads.xlsx" %>">here</a></label>
                        </div>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                        <% List<Entities.InspectionLeads> dList = Bll.InspectionLeads.Select(RecordID, filter: ""); %>
                        <div class="form-group">
                            <label>Assigned Sales Executive *</label>
                            <select id="SalesExecutive" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].SalesExecutive : 0 %>" required>
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <% List<Entities.zUsers> dataList = Bll.zUsers.Select(0, filter: " AND CatID=1 AND Statu=5 AND Approved=1");
                                    foreach (var items in dataList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].SalesExecutive == items.id ? " selected" : "" : "" %>><%= items.Name + " " + items.Surname %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Leads Date</label>
                            <input id="LeadsDate" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].LeadsDate : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Name</label>
                            <input id="Name" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Name : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Surname</label>
                            <input id="Surname" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Surname : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input id="Phone" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Phone : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input id="Email" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Email : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Lead Channel</label>
                            <input id="Channel" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Channel : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Adv. Info</label>
                            <input id="AdvInformation" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].AdvInformation : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Call</label>
                            <input id="Call" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Call : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Occupationl</label>
                            <input id="Occupation" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Occupation : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Age</label>
                            <input id="Age" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Age : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Country</label>
                            <input id="Country" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Country : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>City</label>
                            <input id="City" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].City : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Butce") %></label>
                            <div class="input-group">
								<div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="Budget" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].Budget : "0" %>" />
							</div>
                            <small><%= Language.GetFixed("FiyatAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label>Interested Property</label>
                            <input id="InterestedProperty" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].InterestedProperty : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Message</label>
                            <textarea id="Message" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Message : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label>Notes</label>
                            <textarea id="Notes" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Notes : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label>Interested or Not</label>
                            <textarea id="isInterested" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].isInterested : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label>Result</label>
                            <textarea id="Result" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Result : ""%></textarea>
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
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>