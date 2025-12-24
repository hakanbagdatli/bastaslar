<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="WebSite.Raven.Reservation.Transactions" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Entities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="36" />
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
                                    <% if (Request["dhx"] == null) { %>
                                     <a href="?dhx=add&catid=<%= Request["catid"] %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
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
                                        <th><%= Language.GetFixed("Miktar") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 100px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%   double TotalAmount = 0;
                                        List<Entities.SaleTransactions> dList = Bll.SaleTransactions.Select(0, filter: whereClause,  sorting: " Sorting ASC, id ASC");
                                        foreach (var item in dList) {
                                            TotalAmount += (Convert.ToBoolean(item.Approved) ? Helper.MoneytoDouble(item.Amount) : 0); %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id %></td>
                                            <td><%= item.Title  %></td>
                                            <td><%= item.Amount + " " + item.Currency  %></td>
                                            <td>
                                                <input id="txtSort<%= item.id %>" name="Sorting" type="text" class="form-control list-form-data center" autocomplete="off" value="<%= item.Sorting %>" />
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
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckApp<%= item.id %>" name="Approved" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Approved) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <a href="?dhx=edit&id=<%= item.id + "&catid=" + item.CatID %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Duzenle") %>"><i class="la la-edit"></i></a>
                                                <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Sil") %>"><i class="la la-trash"></i></a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                                <tfoot style="background: #f2f2f4;">
                                    <tr>
                                        <td></td>
                                        <td><%= Language.GetFixed("ToplamTutar") %></td>
                                        <td><%= Helper.MoneyFormat(TotalAmount)  %></td>
                                        <td colspan="4"></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <% } else { %>

                        <!-- body -->
                        <div class="card-body">
                            <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                            <input id="CatID" class="form-control form-data" type="hidden" value="<%= CatID %>" />
                            <% List<Entities.SaleTransactions> dList = Bll.SaleTransactions.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Baslik") %></label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Title : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%=Language.GetFixed("Miktar") %></label>
                                <input id="Amount" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].Amount.ToString() : "0" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("ParaBirimi") %></label>
                                <input id="Currency" class="form-control form-data" type="number" value="<%= RecordID > 0 ? dList[0].Currency.ToString() : "GBP" %>" disabled />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("KisaIcerik") %></label>
                                <textarea id="ShortContent" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ShortContent : "" %></textarea>
                            </div>
                            <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].Filename)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowImage(dList[0].Filename) : "" %></td>
                                        <td><%= RecordID > 0 ? Developer.DeleteFileButton("files", "Filename", dList[0].Filename) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Dosya") %></label>
                                <div class="custom-file">
                                    <input id="Filename" class="custom-file-input form-data" type="file" data-crop="false" data-path="files" />
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
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>