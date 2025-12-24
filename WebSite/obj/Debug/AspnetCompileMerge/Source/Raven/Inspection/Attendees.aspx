<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Attendees.aspx.cs" Inherits="WebSite.Raven.Inspection.Attendees" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="38" />
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
                                <a href="?dhx=add&catid=<%= CatID %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
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
                                    <th><%= Language.GetFixed("GosterimNo") %></th>
                                    <th><%= Language.GetFixed("AcentaAdi") %></th>
                                    <th><%= Language.GetFixed("AdSoyad") %></th>
                                    <th><%= Language.GetFixed("Butce") %></th>
                                    <th style="width:100px"><%= Language.GetFixed("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.Attendees> dList = Bll.Attendees.Select(0, filter: whereClause);
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.InspectionNumber %></td>
                                        <td><%= item._AgencyName %></td>
                                        <td><%= item.Fullname %></td>
                                        <td><%= item.Budget %></td>
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
                        <% List<Entities.Attendees> dList = Bll.Attendees.Select(RecordID, filter: ""); %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("AdSoyad") %></label>
                            <input id="Fullname" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Fullname : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Butce") %></label>
                            <div class="input-group">
								<div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="Budget" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].Budget : "0" %>" />
							</div>
                            <small><%= Language.GetFixed("FiyatAciklama") %></small>
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