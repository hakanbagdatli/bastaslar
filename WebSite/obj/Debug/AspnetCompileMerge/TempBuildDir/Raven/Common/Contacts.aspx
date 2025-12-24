<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="WebSite.Raven.Common.Contacts" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="5" />
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
                                        <th><%= Language.GetFixed("Kategori") %></th>
                                        <th><%= Language.GetFixed("SubeAdi") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 100px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.GeneralContacts> dList = Bll.GeneralContacts.Select(0, filter: "");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id  %></td>
                                            <td>
                                                <a href="javascript:;" data-toggle='tooltip' data-theme='dark' title="<%= Select.MultipleCategoryName(Convert.ToInt32(item.CatID)) %>">
                                                    <%= item._CategoryName %>
                                                </a>
                                            </td>
                                            <td><%= item.BranchName  %></td>
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
                            <% List<Entities.GeneralContacts> dList = Bll.GeneralContacts.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("UstKategoriAdi") %></label>
                                <select id="CatID" class="form-control form-data form-data-option">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% List<Entities.GeneralCategories> dataList = Entities.StaticList.Categories.Where(x => (x.PageTypeID == 13)).ToList();
                                        foreach (var items in dataList) { %>
                                        <option value="<%= items.id %>" <%= dList.Count > 0 && dList[0].CatID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("SubeAdi") %></label>
                                <input id="BranchName" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].BranchName : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Email") %> (for sale)</label>
                                <input id="Email" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Email : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Email") %> (for rent)</label>
                                <input id="Email2" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Email2 : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Telefon") %> (for sale)</label>
                                <input id="Phone" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Phone : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Telefon") %> (for rent)</label>
                                <input id="Gsm" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Gsm : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Adres") %></label>
                                <textarea id="Address" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].Address : "" %></textarea>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("GoogleMapEmbed") %></label>
                                <textarea id="GoogleMap" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].GoogleMap : "" %></textarea>
                            </div>
                            <!--
                            <div class="form-group">
                                <label><%= Language.GetFixed("Faks") %></label>
                                <input id="Fax" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Fax : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Telefon") %> 2</label>
                                <input id="Phone2" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Phone2 : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Koordinat") %></label>
                                <textarea id="GoogleCoordinate" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].GoogleCoordinate : ""%></textarea>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("YolTarifiLink") %></label>
                                <textarea id="GoogleMapLink" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].GoogleMapLink : ""%></textarea>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Aciklama") %></label>
                                <textarea id="Description" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].Description : ""%></textarea>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Enlem") %></label>
                                <textarea id="GoogleLatitude" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].GoogleLatitude : ""%></textarea>
                                <input ID="txtGoogleLatitude" runat="server" Height="110px" TextMode="MultiLine" class="form-control" placeholder="Google Map Enlem" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Boylam") %></label>
                                <textarea id="GoogleLongitude" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].GoogleLongitude : ""%></textarea>
                            </div>
                            -->
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