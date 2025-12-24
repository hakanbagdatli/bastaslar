<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="WebSite.Raven.Reservation.Reports" %>

<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

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
                                <a href="javascript:;" class="btn btn-primary btn-filter font-weight-bold"><i class="la la-search"></i>&nbsp;<%= Language.GetFixed("RaporOlustur") %></a>
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-6 mb-4">
                                <label><%= Language.GetFixed("RaporTuru") %>:</label>
                                <select id="Type" class="form-control filter-data">
                                    <option value="1">Reservation & Completed Sales Report</option>
                                    <option value="2">Reservation & Completed Sales Details Report</option>
                                    <option value="3">Ins. Trip / Property View Report </option>
                                </select>
                            </div>
                            <div class="col-lg-6 mb-5">
                                <label><%= Language.GetFixed("TarihAraligi") %>:</label>
                                <div class="input-daterange input-group" id="kt_rangerpicker1">
                                    <input id="StartDate" type="text" class="form-control datatable-input filter-data" name="start" placeholder="From" data-col-index="5" autocomplete="off">
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="la la-ellipsis-h"></i>
                                        </span>
                                    </div>
                                    <input id="EndDate" type="text" class="form-control datatable-input filter-data"name="end" placeholder="To" data-col-index="5" autocomplete="off">
                                </div>
                            </div>
                            <div class="col-lg-6 mb-5">
                                <label><%= Language.GetFixed("IlgiliPersonel") %>:</label>
                                <select id="SaleExecutive" class="form-control form-data selectpicker" data-live-search="true" type="select" onchange="SelectedChange('SaleExecutive','GetSaleExecutiveAgency','AgencyID')">
                                    <option value="0"><%= Language.GetFixed("TumunuGor") %></option>
                                    <% List<Entities.zUsers> saleExecutiveList = Bll.zUsers.Select(0, filter: " AND CatID=1 AND Statu=5 AND Approved=1", sorting: " Name ASC");
                                        foreach (var items in saleExecutiveList) { %>
                                        <option value="<%= items.id %>"><%= items.Name + " " + items.Surname %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col-lg-6 mb-5">
                                <label><%= Language.GetFixed("AcentaAdi") %>:</label>
                                <select id="Agency" class="form-control form-data selectpicker" data-live-search="true" >
                                    <option value="0"><%= Language.GetFixed("TumunuGor") %></option>
                                    <% List<Entities.Agencies> agencyList = Bll.Agencies.Select(0, filter: " AND Approved=1", sorting: " Title ASC");
                                        foreach (var items in agencyList) { %>
                                        <option value="<%= items.id %>"><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- body -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-body">

                        <% if (Request["type"] == "1") {  %>
                
                            <div class="reports-title">
                                <span><%= Language.GetFixed("TarihAraligi") %></span>
                                <span><%= Helper.SiteDateFormat(StartDate) %> - <%= Helper.SiteDateFormat(EndDate) %></span>
                            </div>
                            <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Adet</th>
                                        <th>Fiyat</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= Language.GetFixed("Rezervasyon") %></td>
                                        <td><%= Helper.SplitedList("~", TotalResCount)[0] %></td>
                                        <td><%= Helper.SplitedList("~", TotalResCount)[1] %> £</td>
                                    </tr>
                                    <tr>
                                        <td><%= Language.GetFixed("Satislar") %></td>
                                        <td><%= Helper.SplitedList("~", TotalSaleCount)[0] %></td>
                                        <td><%= Helper.SplitedList("~", TotalSaleCount)[1] %> £</td>
                                    </tr>
                                </tbody>
                            </table>

                        <% } else if (Request["type"] == "2") { %>
                            
                            <div class="reports-title">
                                <span><%= Language.GetFixed("TarihAraligi") %></span>
                                <span><%= Helper.SiteDateFormat(StartDate) %> - <%= Helper.SiteDateFormat(EndDate) %></span>
                            </div>
                            <table class="table table-separate table-head-custom table-checkable" id="liophinResTable">
                                <thead>
                                    <tr>
                                        <th><%= Language.GetFixed("Tur") %></th>
                                        <th><%= Language.GetFixed("TakipNo") %></th>
                                        <th><%= Language.GetFixed("Musteriler") %></th>
                                        <th><%= Language.GetFixed("Proje") %></th>
                                        <th><%= Language.GetFixed("Properties") %></th>
                                        <th><%= Language.GetFixed("RezervasyonTarih") %></th>
                                        <th><%= Language.GetFixed("SozlesmeTarihi") %></th>
                                        <th><%= Language.GetFixed("SozlesmeFiyati") %></th>
                                        <th><%= Language.GetFixed("Yuzde35Miktarı") %></th>
                                        <th><%= Language.GetFixed("OdenenTutar") %></th>
                                        <th><%= Language.GetFixed("KalanTutar") %></th>
                                        <th><%= Language.GetFixed("AliciMilliyeti") %></th>
                                        <th><%= Language.GetFixed("Avukat") %></th>
                                        <th><%= Language.GetFixed("AcentaAdi") %></th>
                                        <th><%= Language.GetFixed("IlgiliPersonel") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        List<Entities.Reservations> dList = Bll.Reservations.Select(0, filter: ResWhereClause, sorting: " id DESC");
                                        foreach (var item in dList) { 
                                            string Percentof35 = Helper.CalculatePercentage(Helper.MoneytoDouble(item.ContractPrice), 35);
                                            string TotalPaid = PaidAmount(item.id);
                                            string Remaining = RemainingAmount(item.ContractPrice, TotalPaid); %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.TurID == 1 ? "Completed" : "Reservation"  %></td>
                                            <td><%= item.TurID == 1 ? item.SaleNumber : item.ReservationNumber %></td>
                                            <td><%= item._CustomerName + " " + item._CustomerSurname %></td>
                                            <td><%= item._ProjectName %></td>
                                            <td><%= item._PlanName %></td>
                                            <td><%= item.ReservationDate %></td>
                                            <td><%= item.ContractofSigning %></td>
                                            <td><%= item.ContractPrice %></td>
                                            <td><%= Percentof35 %></td>
                                            <td><%= TotalPaid %></td>
                                            <td><%= TotalPaid %></td>
                                            <td><%= item._CustomerCountry %></td>
                                            <td><%= item._CustomerLawyer %></td>
                                            <td><%= item._AgencyName %></td>
                                            <td><%= item._SaleExecutive %></td>
                                        </tr>
                                    <% }     
                                        dList = Bll.Reservations.Select(0, filter: SalWhereClause, sorting: " id DESC");
                                        foreach (var item in dList) { 
                                            string Percentof35 = Helper.CalculatePercentage(Helper.MoneytoDouble(item.ContractPrice), 35);
                                            string TotalPaid = PaidAmount(item.id);
                                            string Remaining = RemainingAmount(item.ContractPrice, TotalPaid); %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.TurID == 1 ? "Completed" : "Reservation"  %></td>
                                            <td><%= item.TurID == 1 ? item.SaleNumber : item.ReservationNumber %></td>
                                            <td><%= item._CustomerName + " " + item._CustomerSurname %></td>
                                            <td><%= item._ProjectName %></td>
                                            <td><%= item._PlanName %></td>
                                            <td><%= item.ReservationDate %></td>
                                            <td><%= item.ContractofSigning %></td>
                                            <td><%= item.ContractPrice %></td>
                                            <td><%= Percentof35 %></td>
                                            <td><%= TotalPaid %></td>
                                            <td><%= TotalPaid %></td>
                                            <td><%= item._CustomerCountry %></td>
                                            <td><%= item._CustomerLawyer %></td>
                                            <td><%= item._AgencyName %></td>
                                            <td><%= item._SaleExecutive %></td>
                                        </tr>
                                    <% }%>
                                </tbody>
                            </table>

                        <% } else if (Request["type"] == "3") { %>
                    
                            <div class="reports-title">
                                <span><%= Language.GetFixed("TarihAraligi") %></span>
                                <span><%= Helper.SiteDateFormat(StartDate) %> - <%= Helper.SiteDateFormat(EndDate) %></span>
                            </div>
                            <table class="table table-separate table-head-custom table-checkable" id="liophinResTable">
                                <thead>
                                    <tr>
                                        <th><%= Language.GetFixed("Tur") %></th>
                                        <th><%= Language.GetFixed("TakipNo") %></th>
                                        <th><%= Language.GetFixed("MusteriAdi") %></th>
                                        <th><%= Language.GetFixed("AcentaAdi") %></th>
                                        <th><%= Language.GetFixed("KonaklamaCheckinTarihi") %></th>
                                        <th><%= Language.GetFixed("SunumTarihi") %></th>
                                        <th><%= Language.GetFixed("MusteriButcesi") %></th>
                                        <th><%= Language.GetFixed("Proje") %></th>
                                        <th><%= Language.GetFixed("Durum") %></th>
                                        <th><%= Language.GetFixed("IlgiliPersonel") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        List<Entities.Inspections> dList = Bll.Inspections.Select(0, filter: InsWhereClause, sorting: " id DESC");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.TurID == 0 ? "Inspection" : "Property View"  %></td>
                                            <td><%= item.PNRCode %></td>
                                            <td><%= string.Join(", ", Bll.Attendees.Select(0, " AND id in (" + item.Clients + ")").ToList().Select(attend => attend.Fullname)) %></td>
                                            <td><%= item._AgencyName %></td>
                                            <td><%= Helper.SiteDateFormat(item.CheckinDate) %>&nbsp;</td>
                                            <td><%= Helper.SiteDateFormat(item.PresentationDate) %>&nbsp;</td>
                                            <td><%= string.Join(", ", Bll.Attendees.Select(0, " AND id in (" + item.Clients + ")").ToList().Select(attend => attend.Budget)) %></td>
                                            <td><%= string.Join(", ", item._Projects.Select(project => project.Title)) %></td>
                                            <td><%= item._Statu %></td>
                                            <td><%= item._SaleExecutive %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>

                        <% } %>

                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript">
        $('#kt_rangerpicker1, #kt_rangerpicker2').datepicker({
            rtl: KTUtil.isRTL(),
            format: "dd.mm.yyyy",
            orientation: "bottom left",
            todayHighlight: true
        });

        /* fitrele */
        $(".btn-filter").on("click", function () {
            let filterURL = "";
            // Include inputs with class filter-data and selects with class form-data
            $(".filter-data, select.form-data").each(function () {
                let dataID = ($(this).attr("id") || "").toLowerCase();
                let dataValue = $(this).val();
                let isSelect = $(this).is('select');
                if (dataID && dataValue != null && dataValue !== "") {
                    if (isSelect) {
                        if (dataValue != 0) {
                            filterURL += dataID + "=" + dataValue + "&";
                        }
                    } else {
                        filterURL += dataID + "=" + dataValue + "&";
                    }
                }
            });
            //------------------------------------------
            if (filterURL != "")
                window.location = "<%= Developer.ConstantUrl("resreports") %>?" + filterURL.slice(0, -1);
        });

    </script>
</asp:Content>