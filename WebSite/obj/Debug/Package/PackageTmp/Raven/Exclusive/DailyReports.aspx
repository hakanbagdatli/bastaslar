<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="DailyReports.aspx.cs" Inherits="WebSite.Raven.Exclusive.DailyReports" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="39" />
    <div class="d-flex flex-column-fluid">
        <div class="container">
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
                                    <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("ListeGuncelle") %></a>
                                    <% } else if (Request["dhx"] != null) {  %>
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
                                        <th><%= Language.GetFixed("Personel") %></th>
                                        <th><%= Language.GetFixed("RaporTuru") %></th>
                                        <th><%= Language.GetFixed("Tarih") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 250px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.DailyReports> dList = Bll.DailyReports.Select(0, filter: "", sorting: " id DESC");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id  %></td>
                                            <td><%= item._Username %></td>
                                            <td><%= item._ReportName %></td>
                                            <td><%= Utility.Helper.SiteDateFormat(item.CreatedDate.ToString()) %></td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckDel<%= item.id %>" name="isDeleted" type="checkbox" class="list-form-data" />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <% if (!String.IsNullOrEmpty(item.Filename)) { %>
                                                    <a href="<%= Utility.Feature.ReportFileFolder + item.Filename %>" target="_blank" class="btn btn-outline-secondary font-weight-bold">Show Report</a>
                                                    <% } else { %>
                                                    <a href="javascript:;" data-id="<%= item.id %>" class="btn btn-create-daily btn-outline-secondary font-weight-bold">Create Report</a>
                                                    <% } %>
                                                    <% if (Helper.SQLDateFormat(item.CreatedDate.ToString()) == Helper.SQLDateFormat(DateTime.Now.ToString())) { %>
                                                    <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-outline-secondary font-weight-bold" title="<%= Language.GetFixed("Duzenle") %>">
                                                        <%= Language.GetFixed("Duzenle") %>
                                                    </a>
                                                    <% } %>
                                                    <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-outline-secondary font-weight-bold"><%= Language.GetFixed("Sil") %></a>
                                                </div>
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
                            <input id="Questions" class="form-control form-data" type="hidden" value="0" />
                            <input id="Answers" class="form-control form-data" type="hidden" value="0" />
                            <% List<Entities.DailyReports> dList = Bll.DailyReports.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("RaporTuru") %></label>
                                <select id="ReportID" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].ReportID : 0 %>">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 6) && (x.DefineID == 0))) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 && dList[0].ReportID == items.id ? " selected" :  "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div id="ReportDetail"></div>
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
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script src="/raven/assets/vendors/page.daily.js?v=<%= Feature.Version %>"></script>
</asp:Content>