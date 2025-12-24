<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Preview.aspx.cs" Inherits="WebSite.Raven.Reservation.Preview" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <div class="d-flex flex-column-fluid">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">

                    <!-- header -->
                    <div class="card card-custom gutter-b example example-compact">
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
                                    <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold">
                                        <i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card card-custom gutter-b example example-compact">
                        <div class="card-body p-0">

                            <!-- header -->
                            <div class="row justify-content-center bgi-size-cover bgi-no-repeat py-8 px-8 py-md-27 px-md-0" style="background-image: url(/raven/assets/media/preview.jpg);">
                                <div class="col-md-9">
                                    <% foreach (var item in dataList) { %>
                                    <div class="d-flex justify-content-between pb-10 pb-md-20 flex-column flex-md-row">
                                        <h1 class="display-4 text-white font-weight-boldest mb-10"><%= item.TurID == 0 ? "RESERVATION" : "SALE"  %></h1>
                                        <div class="d-flex flex-column align-items-md-end px-0">
                                            <a href="#" class="mb-5">
                                                <img src="assets/media/logos/logo-light.png" alt="">
                                            </a>
                                            <span class="text-white d-flex flex-column align-items-md-end opacity-70">
                                                <span><%= item._CustomerName + " " + item._CustomerSurname %></span>
                                                <span><%= item._CustomerEmail %></span>
                                                <span><%= item._CustomerPhone  %></span>
                                                <span><%= item._CustomerCountry %></span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="border-bottom w-100 opacity-20"></div>
                                    <div class="d-flex justify-content-between text-white pt-6">
                                        <div class="d-flex flex-column flex-root">
                                            <span class="font-weight-bolde mb-2r"><%= Language.GetFixed("AcentaAdi") %></span>
                                            <span class="opacity-70"><%= item._AgencyName %></span>
                                        </div>
                                        <div class="d-flex flex-column flex-root">
                                            <span class="font-weight-bolder mb-2"><%= Language.GetFixed("Proje") %></span>
                                            <span class="opacity-70"><%= item._ProjectName %></span>
                                        </div>
                                        <div class="d-flex flex-column flex-root">
                                            <span class="font-weight-bolder mb-2"><%= Language.GetFixed("Properties") %></span>
                                            <span class="opacity-70"><%= item._PlanName %></span>
                                        </div>

                                    </div>
                                    <% } %>
                                </div>
                            </div>

                            <!-- begin: Invoice body-->
                            <div class="row justify-content-center py-8 px-8 py-md-10 px-md-0">
                                <div class="col-md-9">
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th class="pl-0 font-weight-bold text-muted text-uppercase">Uploaded Files for this record</th>
                                                    <th class="text-right font-weight-bold text-muted text-uppercase"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% foreach (var item in fileList) { %>
                                                <tr class="font-size-lg">
                                                    <td class="pl-0 pt-7"><%= item.Title %></td>
                                                    <td class="text-right pt-7"><%= Developer.ShowFile(item.Filename) %></td>
                                                </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- payment -->
                            <div class="row justify-content-center bg-gray-100 py-8 px-8 py-md-10 px-md-0">
                                <div class="col-md-9">
                                    <div class="d-flex justify-content-between flex-column flex-md-row font-size-lg">
                                        <div class="d-flex flex-column mb-10 mb-md-0">
                                            <div class="font-weight-bolder font-size-lg mb-3">Payments</div>
                                            <% double TotalAmount = 0;
                                                foreach (var item in paymentList) {
                                                    TotalAmount += Convert.ToDouble(item.Amount);  %>
                                            <div class="d-flex justify-content-between mb-3">
                                                <span class="mr-15 font-weight-bold"><%= item.Title %>:</span>
                                                <span class="text-right"><%= Utility.Helper.MoneyFormat(Convert.ToDouble(item.Amount))  + " - " + item.ShortContent %></span>
                                            </div>
                                            <% } %>
                                        </div>
                                        <div class="d-flex flex-column text-md-right">
                                            <span class="font-size-lg font-weight-bolder mb-1">TOTAL AMOUNT</span>
                                            <span class="font-size-h2 font-weight-boldest text-danger mb-1"><%= Utility.Helper.MoneyFormat(TotalAmount) %></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>
