<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="General.aspx.cs" Inherits="WebSite.Raven.Seo.General" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="Server">
    
    <input id="table" class="form-control" type="hidden" value="15" />
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
                                <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i>&nbsp;Liste Verilerini Güncelle</a>
                                <% } else { %>
                                <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;Kaydet</a>
                                <% } %>
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;Geri Dön</a>
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
                                    <th>Dil</th>
                                    <th>Başlık</th>
                                    <th style="width: 50px;">Onay</th>
                                    <th style="width: 100px;">İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.zLangCodes> dList = Bll.zLangCodes.Select(0, filter: " AND Approved=1", sorting: " Sorting ASC, id ASC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.Title %></td>
                                        <td><%= item.MetaTitle  %></td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckApp<%= item.id %>" name="Approved" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Approved) ? "checked" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-sm btn-clean btn-icon mr-2" title="Düzenle"><i class="la la-edit"></i></a>
                                            <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon mr-2" title="Sil"><i class="la la-trash"></i></a>
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
                        <% List<Entities.zLangCodes> dList = Bll.zLangCodes.Select(RecordID, filter: ""); %>
                        <div class="form-group">
                            <label>Sabit Title</label>
                            <input id="SiteTitle" class="form-control form-data" type="text" value="<%= dList[0].SiteTitle %>" />
                        </div>
                        <div class="form-group">
                            <label>Meta Title</label>
                            <input id="MetaTitle" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].MetaTitle : "" %>" />
                        </div>
                        <div class="form-group">
                            <label>Meta Description</label>
                            <textarea id="MetaDescription" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].MetaDescription : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label>Meta Keywords</label>
                            <textarea id="MetaKeywords" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].MetaKeywords : "" %></textarea>
                        </div>
                        <div class="form-group">
                            <label>Ek Meta Tags</label>
                            <textarea id="AdditionalMetaTags" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].AdditionalMetaTags : "" %></textarea>
                        </div>
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
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server"></asp:Content>