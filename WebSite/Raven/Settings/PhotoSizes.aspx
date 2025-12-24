<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="PhotoSizes.aspx.cs" Inherits="WebSite.Raven.Settings.PhotoSizes" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="18" />
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
                                        <th><%= Language.GetFixed("Baslik") %></th>
                                        <th><%= Language.GetFixed("KucukResim") %></th>
                                        <th>Büyüm Resim</th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 100px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.zPhotoSettings> dList = Bll.zPhotoSettings.Select(0, filter: "");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id  %></td>
                                            <td><%= item.Title %></td>
                                            <td><%= item.ThumbnailWidth + " x " + item.ThumbnailHeight %></td>
                                            <td><%= item.BigImageWidth + " x " + item.BigImageHeight %></td>
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
                            <% List<Entities.zPhotoSettings> dList = Bll.zPhotoSettings.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Baslik") %></label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Title : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Sayfa Tür</label>
                                <select id="PageTypeID" class="form-control form-data form-data-option" data-value="<%= dList.Count > 0 ? dList[0].PageTypeID.ToString() : "0" %>">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% foreach (var items in Entities.StaticList.PageTypes) { %>
                                        <option value="<%= items.id %>" <%= dList.Count > 0 && dList[0].PageTypeID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Kategori") %></label>
                                <select id="CatID" class="form-control form-data form-data-option" data-value="<%= dList.Count > 0 ? dList[0].CatID.ToString() : "0" %>">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% foreach (var items in Entities.StaticList.Categories) { %>
                                        <option value="<%= items.id %>" <%= dList.Count > 0 && dList[0].CatID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Icerik") %></label>
                                <select id="RecordID" class="form-control form-data form-data-option" data-value="<%= dList.Count > 0 ? dList[0].RecordID.ToString() : "0" %>">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% foreach (var items in Entities.StaticList.Records) { %>
                                        <option value="<%= items.id %>" <%= dList.Count > 0 && dList[0].RecordID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Küçük Resim Genişlik</label>
                                <input id="ThumbnailWidth" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].ThumbnailWidth.ToString() : "" %>" />
                                <label>Küçük Resim Yükseklik</label>
                                <input id="ThumbnailHeight" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].ThumbnailHeight.ToString() : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Büyük Resim Genişlik</label>
                                <input id="BigImageWidth" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].BigImageWidth.ToString() : "" %>" />
                                <label>Büyük Resim Yükseklik</label>
                                <input id="BigImageHeight" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].BigImageHeight.ToString() : "" %>" />
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