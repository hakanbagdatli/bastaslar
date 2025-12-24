<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Reservations.aspx.cs" Inherits="WebSite.Partner.Reservations" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="33" />
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
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetPartner("GeriDon") %></a>
                            </div>
                        </div>
                    </div>

                    <% if (Request["dhx"] == null) { %>

                    <!-- body -->
                    <div class="card-body">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinResTable">
                            <thead>
                                <tr>
                                    <th><%= Language.GetPartner("TakipNo") %></th>
                                    <th style="min-width:200px;"><%= Language.GetPartner("AcentaAdi") %></th>
                                    <th style="min-width:120px;"><%= Language.GetPartner("Musteriler") %></th>
                                    <th style="min-width:200px;"><%= Language.GetPartner("Proje") %></th>
                                    <th style="min-width:200px;"><%= Language.GetPartner("Properties") %></th>
                                    <th><%= Language.GetPartner("Komisyon") %></th>
                                    <th><%= Language.GetPartner("SozlesmeFiyati") %></th>
                                    <th><%= Language.GetPartner("DepozitoOdendi") %></th>
                                    <th><%= Language.GetPartner("Pesinat") %></th>
                                    <th><%= Language.GetPartner("KomisyonOdendi") %></th>
                                    <th><%= Language.GetPartner("Durum") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    double TotalCommission = 0, TotalPrice = 0;
                                    List<Entities.Reservations> dList = Bll.Reservations.Select(0, filter: whereClause, sorting: " id DESC");
                                    foreach (var item in dList) { 
                                        TotalCommission += Helper.MoneytoDouble(item.AgencyCommission);
                                        TotalPrice += Helper.MoneytoDouble(item.ContractPrice); %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%=  item.ReservationNumber %></td>
                                        <td><%= item._AgencyName %></td>
                                        <td><%= item._CustomerName + " " + item._CustomerSurname %></td>
                                        <td><%= item._ProjectName %></td>
                                        <td><%= item._PlanName %></td>
                                        <td><%= item.AgencyCommission %> £</td>
                                        <td><%= item.ContractPrice %> £</td>
                                        <td><span class="label label-lg label-light-<%= Convert.ToBoolean(item.isDepositPaid) ? "success" : "danger"  %> label-inline">
                                            <%= Convert.ToBoolean(item.isDepositPaid) ? Language.GetPartner("Evet") : Language.GetPartner("Hayir")  %></span></td>
                                        <td><span class="label label-lg label-light-<%= Convert.ToBoolean(item.hasDownPayment) ? "success" : "danger"  %> label-inline">
                                            <%= Convert.ToBoolean(item.hasDownPayment) ? Language.GetPartner("Evet") : Language.GetPartner("Hayir")  %></span></td>
                                        <td><span class="label label-lg label-light-<%= Convert.ToBoolean(item.isCommissionPaid) ? "success" : "danger"  %> label-inline">
                                            <%= Convert.ToBoolean(item.isCommissionPaid) ? Language.GetPartner("Evet") : Language.GetPartner("Hayir")  %></span></td>
                                        <td><span class="label label-lg label-light-<%= item._StatuColor %> label-inline"><%= item._Statu %></span></td>
                                    </tr>
                                <% } %>
                            </tbody>
                            <tfoot style="background: #f2f2f4;">
                                <tr>
                                    <td colspan="4"></td>
                                    <td><%= Language.GetPartner("ToplamKomisyon") %></td>
                                    <td><%= Helper.MoneyFormat(TotalCommission)  %></td>
                                    <td colspan="4"></td>
                                </tr>
                                <tr>
                                    <td colspan="4"></td>
                                    <td><%= Language.GetPartner("ToplamSozlesmeBedeli") %></td>
                                    <td></td>
                                    <td><%= Helper.MoneyFormat(TotalPrice) %></td>
                                    <td colspan="3"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <% } %>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>