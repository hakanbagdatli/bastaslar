<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="TaskList.aspx.cs" Inherits="WebSite.Raven.Operation.TaskList" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="37" />
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
                                        <th style="width: 250px;"><%= Language.GetFixed("Baslik") %></th>
                                        <th><%= Language.GetFixed("IlgiliPersonel") %></th>
                                        <th><%= Language.GetFixed("Tarih") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 150px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.Assignments> dList = Bll.Assignments.Select(0, filter: "", sorting: " id DESC");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id  %></td>
                                            <td><%= item.Title %></td>
                                            <td><%= string.Join(", ", item._Users.Select(user => user.Name + " " + user.Surname)) %></td>
                                            <td><%= Utility.Helper.SiteDateFormat(item.TaskDate) + " - " + item.TaskTime %></td>
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
                            <% List<Entities.Assignments> dList = Bll.Assignments.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Baslik") %></label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Title : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("IlgiliPersonel") %></label>
                                <select id="UserID" class="form-control form-data form-data-option multiselect" multiple>
                                    <%  ArrayList userList = new ArrayList();
                                        if (RecordID > 0)
                                            userList = Utility.Helper.SplitedList(",", dList[0].UserID);
                                        List<Entities.zUsers> projectList = Bll.zUsers.Select(0, filter: " AND CatID=1 AND Statu=5 AND Approved=1");
                                        foreach (var items in projectList) { %>
                                        <option value="<%= items.id %>" <%= inList(userList, items.id) ? " selected" : "" %>><%= items.Name + " " + items.Surname %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Tarih") %></label>
                                <input id="TaskDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].TaskDate : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Saat") %></label>
                                <input id="TaskTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].TaskTime : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Aciklama") %></label>
                                <div class="col-md-12">
                                    <textarea id="Description" class="form-control form-data summernote" rows="4"><%= RecordID > 0 ? dList[0].Description : "" %></textarea>
                                </div>
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
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>