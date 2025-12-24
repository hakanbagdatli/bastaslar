<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="WebSite.Partner.Tasks" %>
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
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= Language.GetPartner("IsTanimlama") %></a></li>
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
                    <% if (Request["dhx"] == null) { %>

                    <!-- body -->
                    <div class="card-body" style="overflow-x:auto">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">ID</th>
                                        <th><%= Language.GetPartner("Baslik") %></th>
                                        <th><%= Language.GetPartner("IlgiliPersonel") %></th>
                                        <th><%= Language.GetPartner("Tarih") %></th>
                                    <th style="width: 250px;"><%= Language.GetPartner("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.Assignments> dList = Bll.Assignments.Select(0, filter: " AND UserID='" + UserData.id + "'", sorting: " id DESC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                            <td><%= item.Title %></td>
                                            <td><%= string.Join(", ", item._Users.Select(user => user.Name + " " + user.Surname)) %></td>
                                            <td><%= Utility.Helper.SiteDateFormat(item.TaskDate) + " - " + item.TaskTime %></td>
                                        <td>
                                            <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-secondary font-weight-bold"><%= Language.GetPartner("DetayliBilgi") %></a>
                                            <% if (Convert.ToInt32(item.CreatedUser) == UserData.id) { %>
                                            <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-danger font-weight-bold"><%= Language.GetPartner("Sil") %></a>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <input id="table" class="form-control" type="hidden" value="37" />
                        <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                        <input id="UserID" class="form-control form-data" type="hidden" value="<%= UserData.id %>" />
                        <% List<Entities.Assignments> dList = Bll.Assignments.Select(RecordID, filter: ""); %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Baslik") %></label>
                            <input id="Title" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Title : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Tarih") %></label>
                            <input id="TaskDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].TaskDate : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Saat") %></label>
                            <input id="TaskTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].TaskTime : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Aciklama") %></label>
                            <div class="col-md-12">
                                <textarea id="Description" class="form-control form-data summernote" rows="4" disabled><%= RecordID > 0 ? dList[0].Description : "" %></textarea>
                            </div>
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