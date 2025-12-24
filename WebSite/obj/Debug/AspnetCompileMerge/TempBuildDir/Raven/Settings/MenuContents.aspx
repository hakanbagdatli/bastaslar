<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="MenuContents.aspx.cs" Inherits="WebSite.Raven.Settings.MenuContents" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="4" />
    <div class="d-flex flex-column-fluid">
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
                                    <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("ListeGuncelle") %></a>
                                    <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                                </div>
                            </div>
                        </div>

                        <!-- body -->
                        <div class="card-body">
                            <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">ID</th>
                                        <th><%= Language.GetFixed("Kategori") %></th>
                                        <th><%= Language.GetFixed("AltKategoriSayfaTur") %></th>
                                        <th><%= Language.GetFixed("Link") %></th>
                                        <th><%= Language.GetFixed("KisaIcerik") %></th>
                                        <th><%= Language.GetFixed("Icerik") %></th>
                                        <th><%= Language.GetFixed("AltKategori") %></th>
                                        <th><%= Language.GetFixed("Silinmez") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.GeneralCategories> dList = Entities.StaticList.Categories;
                                       List<Entities.zPageTypes> dataList = Entities.StaticList.PageTypes;
                                        foreach (var item in dList.Where(x => x.CatID == 0)) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id  %></td>
                                            <td><%= item.Title  %></td>
                                            <td>
                                                <select id="drpSubPage<%= item.id %>" name="SubPageTypeID" class="form-control list-form-data form-data-option">
                                                    <option value="0">Lütfen seçim yapınız</option>
                                                    <% foreach (var items in dataList) { %>
                                                        <option value="<%= items.id %>" <%= item.SubPageTypeID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckLink<%= item.id %>" name="MenuLinkStatu" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.MenuLinkStatu) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckShort<%= item.id %>" name="ShortContentStatu" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.ShortContentStatu) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckCont<%= item.id %>" name="ContentStatu" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.ContentStatu) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckSubCat<%= item.id %>" name="canAddSubCategory" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.canAddSubCategory) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckCanDel<%= item.id %>" name="canDelete" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.canDelete) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                        </tr>
                                    <% foreach (var sub in dList.Where(x => x.CatID == item.id)) { %>
                                        <tr class="list-data" data-id="<%= sub.id %>">
                                            <td><%= sub.id  %></td>
                                            <td><img src="/raven/assets/media/more.gif" class="mr-2"><%= sub.Title  %></td>
                                            <td>
                                                <select id="drpSubPage<%= sub.id %>" name="SubPageTypeID" class="form-control list-form-data form-data-option">
                                                    <option value="0">Lütfen seçim yapınız</option>
                                                    <% foreach (var items in dataList) { %>
                                                        <option value="<%= items.id %>" <%= sub.SubPageTypeID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckLink<%= sub.id %>" name="MenuLinkStatu" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(sub.MenuLinkStatu) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckShort<%= sub.id %>" name="ShortContentStatu" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(sub.ShortContentStatu) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckCont<%= sub.id %>" name="ContentStatu" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(sub.ContentStatu) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckSubCat<%= sub.id %>" name="canAddSubCategory" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(sub.canAddSubCategory) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckCanDel<%= sub.id %>" name="canDelete" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(sub.canDelete) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                        </tr>
                                    <% } }%>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>