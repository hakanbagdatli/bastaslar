<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Languages.aspx.cs" Inherits="WebSite.Raven.Settings.Languages" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="12" />

    <div class="d-flex flex-column-fluid">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-10">
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
                                    <a href="?dhx=add" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;Yeni Kayıt</a>
                                    <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i>&nbsp;Liste Verilerini Güncelle</a>
                                    <% } else { %>
                                    <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;Kaydet</a>
                                    <% } %>
                                    <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;Geri Dön</a>
                                </div>
                            </div>
                        </div>

                        <% if (Request["dhx"] == null)
                            { %>

                        <!-- body -->
                        <div class="card-body">
                            <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">ID</th>
                                        <th style="width: 75px;">İlgili Dil</th>
                                        <th>Başlık</th>
                                        <th style="width: 100px;">İşlem</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.LangFixed> dList = Bll.LangFixed.Select(0, filter: "", sorting: " id ASC");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id  %></td>
                                            <td>English</td>
                                            <td><%= item.LangEN  %></td>
                                            <td>
                                                <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-sm btn-clean btn-icon mr-2" title="Düzenle"><i class="la la-edit"></i></a>
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
                            <% List<Entities.LangFixed> dList = Bll.LangFixed.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label>English</label>
                                <input id="LangEN" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangEN : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Türkçe</label>
                                <input id="LangTR" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangTR : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>German</label>
                                <input id="LangDE" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangDE : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Russian</label>
                                <input id="LangRU" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangRU : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Persian</label>
                                <input id="LangFA" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangFA : "" %>" />
                            </div>
                            <!--<div class="form-group">
                                <label>French</label>
                                <input id="LangFR" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangFR : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Spanish</label>
                                <input id="LangES" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangES : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Italian</label>
                                <input id="LangIT" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangIT : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Portuguese</label>
                                <input id="LangPT" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].LangPT : "" %>" />
                            </div>-->
                        </div>

                        <!-- footer -->
                        <div class="card-footer">
                            <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;Değişikleri Kaydet&nbsp;</a>
                            <a href="javascript:;" class="btn btn-secondary font-weight-bold" onclick="window.history.back()">Geri Dön</a>
                        </div>

                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>
