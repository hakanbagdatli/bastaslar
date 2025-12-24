<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebSite.Raven.Dashboard" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">
    <div class="container">
        <div class="row">
            
            <!-- rightAside -->
            <div class="col-xl-7">
                <div class="row">
                    
                    <!-- inspectionsAnalytic -->
                    <div class="col-xl-6">

                        <!-- inspections -->
                        <div class="card card-flush bgi-no-repeat bgi-size-contain bgi-position-x-center h-md-50 mb-5 mb-xl-10 bg-warning" style="height: 250px;">
                            <div class="card-header bg-warning border-0 pt-5">
                                <a href="/raven/inbox" title="<%= Language.GetFixed("GelenKutusu")  %>" class="card-title d-flex flex-column text-white">
                                    <% int totalFormCount = Bll.FormIncomings.RowCount("", "FormIncomings");
                                        int totalReadedCount = Bll.FormIncomings.RowCount(" AND isReaded=1", "FormIncomings");
                                        int percantage = Tools.Developer.CalcuatePercantage(totalReadedCount, totalFormCount); %>
                                    <span class="font-weight-boldest font-size-h1"><%= totalFormCount %></span>
                                    <span class="opacity-50 pt-1 fw-bold fs-6"><%= Language.GetFixed("GelenKutusu") %></span>
                                </a>
                            </div>
                            <div class="card-body d-flex align-items-end pt-0">
                                <div class="d-flex align-items-center flex-column mt-3 w-100">
                                    <div class="d-flex justify-content-between fw-bolder fs-6 opacity-50 w-100 mt-auto mb-2 text-white">
                                        <span><%= totalReadedCount %> Okunan</span>
                                        <span>%<%= percantage %></span>
                                    </div>
                                    <div class="progress progress-xs w-100">
                                        <div class="progress-bar bg-white" role="progressbar" style="width: <%= percantage %>%;" aria-valuenow="<%= totalFormCount %>" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- googleAnalytics -->
                        <div class="card card-custom gutter-b" style="height: 250px">
                            <div class="card-body d-flex flex-column p-0">
                                <div class="flex-grow-1 card-spacer pb-0">
                                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                                        <div class="mr-2">
                                            <a href="https://analytics.google.com/" target="_blank" class="text-dark-75 text-hover-primary font-weight-bolder font-size-h3"><%= Language.GetFixed("GoogleAnalytics") %></a>
                                            <div class="text-muted font-size-lg font-weight-bold pt-2"><%= Language.GetFixed("AnalyticAciklama") %></div>
                                        </div>
                                    </div>
                                </div>
                                <div id="kt_tiles_widget_23_chart" class="card-rounded-bottom" data-color="primary" style="height: 100px"></div>
                            </div>
                        </div>

                    </div>

                    <!-- properties -->
                    <div class="col-xl-6">
                        <div class="card card-custom bgi-no-repeat bgi-size-cover gutter-b card-stretch" style="background-image: url(assets/media/projects.jpg); background-position: right;">
                            <div class="card-body d-flex flex-column align-items-start justify-content-start">
                                <div class="p-1 flex-grow-1">
                                    <h3 class="text-white font-weight-bolder line-height-lg mb-5"><%= Language.GetFixed("Projeler") %></h3>
                                </div>
                                <a href="content-management?catid=3&ptype=15" class="btn btn-link btn-link-warning font-weight-bold"><%= Language.GetFixed("TumunuGor") %></a>
                            </div>
                        </div>
                    </div>

                    <!-- support -->
                    <div class="col-xl-12">
                        <div class="card card-custom bgi-no-repeat bgi-size-cover gutter-b bg-dark" style="height: 250px; background-image: url(assets/media/taieri.svg)">
                            <div class="card-body d-flex">
                                <div class="d-flex py-5 flex-column align-items-start flex-grow-1">
                                    <div class="flex-grow-1">
                                        <a href="#" class="text-white font-weight-bolder font-size-h3"><%= Language.GetFixed("YardimMerkezi") %></a>
                                        <p class="text-white opacity-75 font-weight-bold mt-3"><%= Language.GetFixed("YardimMerkeziAciklama") %></p>
                                    </div>
                                    <a href="tel:mailto:info@atabilisim.pro" class="btn btn-link btn-link-white font-weight-bold"><%= Language.GetFixed("BizeUlasin") %>
                            <span class="svg-icon svg-icon-lg svg-icon-white">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <polygon points="0 0 24 0 24 24 0 24"></polygon>
                                        <rect fill="#000000" opacity="0.3" transform="translate(12.000000, 12.000000) rotate(-90.000000) translate(-12.000000, -12.000000)" x="11" y="5" width="2" height="14" rx="1"></rect>
                                        <path d="M9.70710318,15.7071045 C9.31657888,16.0976288 8.68341391,16.0976288 8.29288961,15.7071045 C7.90236532,15.3165802 7.90236532,14.6834152 8.29288961,14.2928909 L14.2928896,8.29289093 C14.6714686,7.914312 15.281055,7.90106637 15.675721,8.26284357 L21.675721,13.7628436 C22.08284,14.136036 22.1103429,14.7686034 21.7371505,15.1757223 C21.3639581,15.5828413 20.7313908,15.6103443 20.3242718,15.2371519 L15.0300721,10.3841355 L9.70710318,15.7071045 Z" fill="#000000" fill-rule="nonzero" transform="translate(14.999999, 11.999997) scale(1, -1) rotate(90.000000) translate(-14.999999, -11.999997)"></path>
                                    </g>
                                </svg>
                            </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <!-- leftAside -->
            <div class="col-xl-5">
                <div class="row">

                    <!-- logActivity -->
                    <div class="col-xl-12">
                        <div class="card card-custom card-stretch gutter-b">
                            <div class="card-header border-0 pt-5">
                                <h3 class="card-title align-items-start flex-column">
                                    <span class="card-label font-weight-bolder text-dark"><%= Language.GetFixed("Loglar") %></span>
                                    <span class="text-muted mt-3 font-weight-bold font-size-sm"><%= Language.GetFixed("LogAciklama") %></span>
                                </h3>
                            </div>
                            <div class="card-body pt-7 px-0">

                                <!-- list -->
                                <ul class="nav nav-stretch nav-pills nav-pills-custom nav-pills-active-custom d-flex justify-content-between mb-8 px-5">
                                    <% DataTable dt = Bll.LogRecords.GetDataTable("SELECT DISTINCT CONVERT(date,CreatedDate,104) AS DateNow FROM LogRecords ORDER BY CONVERT(date,CreatedDate,104) DESC", CommandType.Text, null, null);
                                        for (int i = 0; i < 9; i++) { %>
                                    <li class="nav-item p-0 ms-0">
                                        <a href="#tabLog<%= i + 1 %>" data-toggle="tab" class="nav-link btn d-flex flex-column flex-center rounded-pill min-w-45px py-4 px-3<%= i == 0 ? " active" : "" %>">
                                            <span class="fs-7 fw-bold"><%= Convert.ToDateTime(dt.Rows[i][0].ToString()).ToString("ddd") %></span>
                                            <span class="fs-6 fw-bolder"><%= Convert.ToDateTime(dt.Rows[i][0].ToString()).ToString("dd") %></span>
                                        </a>
                                    </li>
                                    <% } %>
                                </ul>

                                <!-- detail -->
                                <div class="tab-content mb-2 px-9">
                                    <% for (int i = 0; i < 9; i++) { %>
                                    <div class="tab-pane fade <%= i == 0 ? " show active" : "" %>" id="tabLog<%= i + 1 %>">
                                        <% List<Entities.LogRecords> activityList = Bll.LogRecords.Select(0, " AND CreatedDate>1 AND CONVERT(date,CreatedDate,104)='" + dt.Rows[i][0].ToString() + "'", " id DESC", 0, 3);
                                            foreach (var item in activityList){ %>
                                        <div class="d-flex align-items-center mb-6">
                                            <span data-kt-element="bullet" class="bullet bullet-vertical d-flex align-items-center min-h-70px mh-100 mr-4 bg-<%= Tools.Developer.LogColor(item.TypeID) %>"></span>
                                            <div class="flex-grow-1 mr-5">
                                                <div class="text-gray-800 fw-bold fs-2"><%= Convert.ToDateTime(item.CreatedDate).ToString("HH:mm") %></div>
                                                <div class="text-gray-700 fw-bold fs-6"><%= item.Description %></div>
                                                <div class="text-gray-400 fw-bold fs-7">
                                                    <%= Language.GetFixed("IslemiYapan") %>  <span class="text-primary opacity-75-hover fw-bold"><%= item._CreatedUserName + " " + item._CreatedUserSurname %></span>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                                    </div>
                                    <% } %>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- socialMedia -->
                    <div class="col-xl-12">
                        <div class="card card-custom bgi-no-repeat gutter-b" style="background-color: #4AB58E;">
                            <div class="card-body">
                                <div class="p-4">
                                    <h3 class="text-white font-weight-bolder my-7"><%= Language.GetFixed("SosyalMedyaSite") %></h3>
                                    <p class="text-white font-size-lg mb-7"><%= Language.GetFixed("SosyalMedyaSiteAciklama") %></p>
                                    <a href="/"  target="_blank" title="Web Site" class="btn btn-icon btn-default mr-2"><i class="la la-globe"></i></a>
                                    <a href="<%= StaticList.Settings.FacebookAddress %>" target="_blank" class="btn btn-icon btn-facebook mr-2"><i class="socicon-facebook"></i></a>
									<a href="<%= StaticList.Settings.TwiterAddress %>" target="_blank" class="btn btn-icon btn-twitter mr-2"><i class="socicon-twitter"></i></a>
									<a href="<%= StaticList.Settings.InstagramAddress %>" target="_blank" class="btn btn-icon btn-instagram mr-2"><i class="socicon-instagram"></i></a>
									<a href="<%= StaticList.Settings.YouTubeAddress %>" target="_blank" class="btn btn-icon btn-youtube mr-2"><i class="socicon-youtube"></i></a>
									<a href="<%= StaticList.Settings.LinkedinAddress %>" target="_blank" class="btn btn-icon btn-linkedin mr-2"><i class="socicon-linkedin"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="/raven/assets/js/widgets.js"></script>
</asp:Content>