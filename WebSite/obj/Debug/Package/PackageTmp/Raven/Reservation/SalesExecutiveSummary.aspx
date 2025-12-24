<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="SalesExecutiveSummary.aspx.cs" Inherits="WebSite.Raven.Reservation.SalesExecutiveSummary" %>

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
                                <label><%= Language.GetFixed("IlgiliPersonel") %>:</label>
                                <select id="SaleExecutive" class="form-control form-data selectpicker" data-live-search="true" type="select"  onchange="SelectedChange('SaleExecutive','GetSaleExecutiveAgency','AgencyID')">
                                    <option value="0"><%= Language.GetFixed("TumunuGor") %></option>
                                    <% List<Entities.zUsers> saleExecutiveList = Bll.zUsers.Select(0, filter: " AND CatID=1 AND Statu=5 AND Approved=1", sorting: " Name ASC");
                                        foreach (var items in saleExecutiveList)
                                        { %>
                                    <option value="<%= items.id %>"><%= items.Name + " " + items.Surname %></option>
                                    <% } %>
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
                                    <input id="EndDate" type="text" class="form-control datatable-input filter-data" name="end" placeholder="To" data-col-index="5" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- body -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-body">
                        <%--BAŞLANGIÇ--%>
                        <div class="reports-title">
                            <span><%= Language.GetFixed("TarihAraligi") %></span>
                            <span><%= Helper.SiteDateFormat(StartDate) %> - <%= Helper.SiteDateFormat(EndDate) %></span>
                        </div>
                        <table class="table table-separate table-head-custom table-checkable" id="liophinResTable">
                            <thead>
                                <tr>
                                    <th>Sales Executive</th>
                                    <th>Touch</th>
                                    <th>Reservation</th>
                                    <th>Completed</th>
                                    <th>Inspection</th>
                                    <th>Property View</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    List<Entities.zSaleExecutiveReport> sedList = Bll.zSaleExecutiveReport.Select(0, saleExecutiveID: int.Parse(SaleExecutiveID), StartDate: Helper.SQLDateFormat(StartDate), EndDate: Helper.SQLDateFormat(EndDate));
                                    foreach (var item in sedList)
                                    { %>
                                <tr class="list-data" data-id="<%= item.SalesExecutive %>">
                                    <td><%= item.SalesExecutive %></td>
                                    <td><%= item.Touch %></td>
                                    <td><%= item.Reservation %></td>
                                    <td><%= item.Completed %></td>
                                    <td><%= item.Inspection %></td>
                                    <td><%= item.PropertyView %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <%--BİTİŞ--%>
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
                window.location = "<%= Developer.ConstantUrl("sales-executive-summary") %>?" + filterURL.slice(0, -1);
        });

    </script>
</asp:Content>
