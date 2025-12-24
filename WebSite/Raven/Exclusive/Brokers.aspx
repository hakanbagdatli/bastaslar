<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Brokers.aspx.cs" Inherits="WebSite.Raven.Exclusive.Brokers" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="22" />
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
                                <% if (CatID > 0) { %>
                                    <a href="?dhx=add&catid=<%= CatID %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
                                <% } %>
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
                                    <th><%= Language.GetFixed("AcentaAdi") %></th>
                                    <th><%= Language.GetFixed("AdSoyad") %></th>
                                    <th><%= Language.GetFixed("Email") %></th>
                                    <th><%= Language.GetFixed("Sil") %></th>
                                    <th><%= Language.GetFixed("Onay") %></th>
                                    <th class="noExport"><%= Language.GetFixed("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.zUsers> dList = Bll.zUsers.Select(0, filter: whereClause);
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item._AgencyName %></td>
                                        <td><%= item.Name + " " + item.Surname %></td>
                                        <td><%= item.Email %></td>
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
                                            <a href="?dhx=edit&id=<%= item.id %>&catid=<%= item.CatID %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Duzenle") %>"><i class="la la-edit"></i></a>
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
                        <input id="CatID" class="form-control form-data" type="hidden" value="<%= CatID %>" />
                        <input id="Statu" class="form-control form-data" type="hidden" value="5" />
                        <% List<Entities.zUsers> dList = Bll.zUsers.Select(RecordID, filter: ""); %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Ad") %></label>
                            <input id="Name" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Name : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Soyad") %></label>
                            <input id="Surname" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Surname : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Email") %></label>
                            <input id="Email" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Email : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Telefon") %></label>
                            <input id="Phone" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Phone : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Sifre") %></label>
                            <input id="Password" class="form-control form-data" type="password" autocomplete="off" />
                        </div>
                        <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].Thumbnail)) { %>
                        <div class="form-group">
                            <table border="0">
                                <tr>
                                    <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowAgencyImage(dList[0].Thumbnail) : "" %></td>
                                    <td><%= RecordID > 0 ? Developer.DeleteFileButton("agencies", "Thumbnail", dList[0].Thumbnail) : "" %></td>
                                </tr>
                            </table>
                        </div>
                        <% } %>
                        <div id="pnlThumbnail" runat="server" class="form-group">
                            <label><%= Language.GetFixed("Resim") %></label>
                            <div class="custom-file">
                                <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>