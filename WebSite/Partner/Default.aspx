<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebSite.Partner.Default" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Entities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/raven/assets/css/custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">
    <div class="container">
        <div class="row">
            
            <% int announcementCount = StaticList.Defines.Where(x => (x.CatID == 8)).ToList().Count;
                if (announcementCount > 0) { %>
            <!-- announcements -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave wave-warning mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pannouncements") %>" title="<%= Language.GetPartner("Duyurular") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150 pulse pulse-warning">
                                    <i class="flaticon-alert icon-5x text-dark"></i>
                                    <span class="pulse-ring" style="width: 100px;height: 100px;top: 0;left: -20px;"></span>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Duyurular") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("TumunuGor") %></span></div>
                        </a>
                    </div>
                </div>
            </div>
            <% } %>

            <!-- projects -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pprojects") %>" title="<%= Language.GetPartner("Projeler") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-home icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Projeler") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("TumunuGor") %></span></div>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- calendar -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pcalendar") %>" title="<%= Language.GetPartner("Takvim") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-calendar-1 icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%=Language.GetPartner("Takvim") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("TumunuGor") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <% if (UserData.CatID == 1) { %>

            <!-- agencies  -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave wave-success mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pagency") %>" title="<%= Language.GetPartner("Acentalar") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-map icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Acentalar") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("TumunuGor") %></span></div>
                        </a>
                    </div>
                </div>
            </div>
            
            <% } %>

            <!-- presentation -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("ppresentation") %>" title="<%= Language.GetPartner("Sunumlar") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-presentation icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Sunumlar") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- documents -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pdocuments") %>" title="<%= Language.GetPartner("Dosyalar") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-open-box icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Dosyalar") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>
            
            <% if (UserData.CatID == 1) { %>
            
            <!-- projectStatus -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave wave-success mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pstatus") %>" title="<%= Language.GetPartner("ProjeDurumlari") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-home icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("ProjeDurumlari") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- dailyreports -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave wave-success mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pdaily") %>" title="<%= Language.GetPartner("GunlukRaporlar") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-folder-1 icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("GunlukRaporlar") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- assignments  -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave wave-success mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("passignments") %>" title="<%= Language.GetPartner("IsTanimlama") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-information icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("IsTanimlama") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- summaries  -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave wave-success mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("psummaries") %>" title="<%= Language.GetPartner("PotansiyelMusteri") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-user-ok icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("PotansiyelMusteri") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            
            <!-- leads  -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave wave-success mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pleads") %>" title="<%= Language.GetPartner("Leads") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-network icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Leads") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <% } %>

            <!-- inspection -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pinspection") %>" title="<%= Language.GetPartner("Gosterimler") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-calendar icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Gosterimler") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("TumunuGor") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- propertyViews -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("ppview") %>" title="<%= Language.GetPartner("Gorunum") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-calendar icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Gorunum") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("TumunuGor") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- customers -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pcustomers") %>" title="<%= Language.GetPartner("Musteriler") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-user icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Musteriler") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("TumunuGor") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- reservations -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("preservations") %>?type=0" title="<%= Language.GetPartner("Rezervasyon") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-calendar-3 icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Rezervasyon") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- inProcess -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("preservations") %>?type=2" title="<%= Language.GetPartner("Surecte") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-calendar-3 icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Surecte") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- completedSales -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("preservations") %>?type=1" title="<%= Language.GetPartner("Satislar") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-calendar-3 icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Satislar") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- projects -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom wave mb-8 mb-lg-0">
                    <div class="card-body text-center pt-4">
                        <a href="<%= Developer.ConstantUrl("pprofile") %>" title="<%= Language.GetPartner("Profil") %>">
                            <div class="mt-7">
                                <div class="symbol symbol-lg-150">
                                    <i class="flaticon-user-settings icon-5x text-dark"></i>
                                </div>
                            </div>
                            <div class="my-4"><span class="text-dark font-weight-bold text-hover-primary font-size-h4"><%= Language.GetPartner("Profil") %></span></div>
                            <div class="mt-9"><span class="btn btn-light-white font-weight-bolder btn-sm py-3 px-6 text-dark"><%= Language.GetPartner("DetayliBilgi") %></span></div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- socialMedia -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom mb-8 mb-lg-0" style="background-color: #4AB58E;">
                    <div class="card-body text-center pt-4">
                        <div class="p-4">
                            <h3 class="text-white font-weight-bolder my-7"><%= Language.GetPartner("SosyalMedya") %></h3>
                            <p class="text-white font-size-lg mb-7"><%= StaticList.Settings.CompanyName + "<br>" + Language.GetPartner("SosyalMedyaSiteAciklama") %></p>
                            <a href="/" target="_blank" title="Web Site" class="btn btn-icon btn-default mr-2"><i class="la la-globe"></i></a>
                            <a href="<%= StaticList.Settings.FacebookAddress %>" target="_blank" class="btn btn-icon btn-facebook mr-2">
                                <i class="socicon-facebook"></i></a>
                            <a href="<%=StaticList.Settings.InstagramAddress %>" target="_blank" class="btn btn-icon btn-instagram mr-2">
                                <i class="socicon-instagram"></i></a>
                            <a href="<%= StaticList.Settings.LinkedinAddress %>" target="_blank" class="btn btn-icon btn-linkedin mr-2">
                                <i class="socicon-linkedin"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <% if (UserData.CatID != 1) { %>
            <!-- saleExecutive -->
            <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 pb-4">
                <div class="card card-custom card-stretch gutter-b">
                    <div class="card-body d-flex flex-column">
                        <% List<Entities.Agencies> agencyList = Bll.Agencies.Select(UserData.CatID, filter: "");
                            foreach (var item in agencyList)
                            { %>
                        <div class="d-flex align-items-center justify-content-center">
                            <div class="symbol symbol-150 symbol-light mr-4">
                                <span class="symbol-label">
                                    <img src="<%= Feature.AgencyFolder + item._RelevantPhoto %>" alt="<%= item._RelevantName %>" class="align-self-end" style="height:150px;" />
                                </span>
                            </div>
                        </div>
                        <div class="pt-5">
                            <p class="text-center font-weight-normal font-size-lg">
                                <%= item._RelevantName + " " + item._RelevantSurname  %><br>
                                <%= item._RelevantPhone  %><br>
                                <%= item._RelevantEmail %>
                            </p>
                            <p class="text-center font-weight-normal font-size-lg pb-7"><%= Language.GetPartner("AcentaDanismani") %></p>
                            <div class="d-flex">
                                <a href="tel:<%= item._RelevantPhone %>" class="btn btn-success btn-shadow-hover font-weight-bolder w-50 py-3 mr-2"><%= Language.GetPartner("Telefon") %></a>
                                <a href="tel:<%= item._RelevantEmail %>" class="btn btn-info btn-shadow-hover font-weight-bolder w-50 py-3"><%= Language.GetPartner("Email") %></a>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <% } %>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>