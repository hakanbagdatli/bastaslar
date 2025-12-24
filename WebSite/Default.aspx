<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebSite.Default" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <!-- slider -->
    <section class="p-0">
        <div class="container-fluid px-0">
            <div class="row">
                <div class="col-lg-12">
                    <div class="main-banner-wrapper home1_style">
                        <div class="banner-style-one dots_none nav_none owl-theme owl-carousel">
                            <% List<Entities.SiteSliders> slideList = Bll.SiteSliders.Select(0, " AND LangID in(0," + Feature.ActiveLanguage + ") AND Approved=1", sorting: " Sorting ASC, id ASC");
                                foreach (var item in slideList) { %>
                            <div class="slide slide-one" style="background-image: url(<%= Feature.ImageFolder + item.Image %>);">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-sm-6 col-xl-5 mb20-md">
                                            <h3 class="banner-title"><%= item.Title %></h3>
                                            <a href="<%= item.Link %>" title="<%= item.LinkTitle %>" target="<%= item.OpeningType %>" class="ud-btn banner-btn fw500 btn-thm mt10 mt0-xs">
                                                <%= item.LinkTitle %><i class="fal fa-arrow-right-long"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <div class="carousel-btn-block banner-carousel-btn">
                            <span class="carousel-btn left-btn"><i class="fas fa-chevron-left left"></i></span>
                            <span class="carousel-btn right-btn"><i class="fas fa-chevron-right right"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- whyChouseUs -->
    <section class="pt-0 pb110 pb50-md bgc-white">
        <div class="container">
            <div class="row mt100 mt60-lg wow fadeInUp" data-wow-delay="00ms">
                <div class="col-lg7 m-auto wow fadeInUp" data-wow-delay="300ms">
                    <div class="main-title text-center">
                        <h2 class="title"><%= Language.GetSite(12) %></h2>
                        <p class="paragraph"><%= Language.GetSite(13) %></p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-lg-6 wow fadeInLeft" data-wow-delay="00ms">
                    <div class="iconbox-style2 text-center">
                        <div class="icon">
                            <img src="/assets/images/icon/buy.png" alt="<%= Language.GetSite(14) %>">
                        </div>
                        <div class="iconbox-content">
                            <h4 class="title"><%= Language.GetSite(14) %></h4>
                            <p class="text"><%= Language.GetSite(15) %></p>
                            <a href="<%= Handler.SetMetaURL(15, 3, false) %>" title="<%= Language.GetSite(16) %>" class="ud-btn btn-white2">
                                <%= Language.GetSite(16) %><i class="fal fa-arrow-right-long"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-6 wow fadeInRight" data-wow-delay="300ms">
                    <div class="iconbox-style2 text-center">
                        <div class="icon">
                            <img src="/assets/images/icon/rent.png" alt="<%= Language.GetSite(17) %>">
                        </div>
                        <div class="iconbox-content">
                            <h4 class="title"><%= Language.GetSite(17) %></h4>
                            <p class="text"><%= Language.GetSite(18) %></p>
                            <a href="<%= Handler.SetMetaURL(6, 4, false) %>" title="<%= Language.GetSite(19) %>" class="ud-btn btn-white2">
                                <%= Language.GetSite(19) %><i class="fal fa-arrow-right-long"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- projects -->
    <section class="pb50-md bgc-f7">
        <div class="container">
            <div class="row align-items-center wow fadeInUp" data-wow-delay="100ms">
                <div class="col-lg-9">
                    <div class="main-title2">
                        <h2 class="title"><%= Language.GetSite(20) %></h2>
                        <p class="paragraph"><%= Language.GetSite(21) %></p>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="text-start text-lg-end mb-3">
                        <a href="<%= Handler.SetMetaURL(5, 2, false) %>" title="<%= Language.GetSite(22) %>" class="ud-btn2">
                            <%= Language.GetSite(22) %><i class="fal fa-arrow-right-long"></i></a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="explore-apartment-5col-slider navi_pagi_bottom_center slider-3-grid owl-carousel owl-theme wow fadeInUp" data-wow-delay="300ms">
                        <% List<Entities.GeneralCategories> projectList = StaticList.Categories.Where(x => (x.CatID == 3) && (x.Approved == 1)).ToList();
                            foreach (var item in projectList) {
                                string recordURL = Handler.SetMetaURL(item.PageTypeID, item.id, false); %>
                        <div class="item">
                            <div class="listing-style7 at-home10">
                                <div class="list-thumb">
                                    <img class="w-100" src="<%= Feature.ImageFolder + Handler.SetImage(item.Image, item._Image) %>" alt="<%= Handler.SetText(item.Title, item._Title) %>">
                                    <div class="list-meta">
                                        <a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title) %>"><span class="flaticon-new-tab"></span></a>
                                        <a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title) %>"><span class="flaticon-fullscreen"></span></a>
                                    </div>
                                </div>
                                <div class="list-content">
                                    <h6 class="list-title"><a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title) %>">
                                        <%= Handler.SetText(item.Title, item._Title) %></a></h6>
                                    <p class="list-text">Çatalköy-Esentepe - KKTC</p>
                                    <hr class="mt-2 mb-2">
                                    <div class="list-meta2 d-flex justify-content-between align-items-center">
                                        <span class="for-what"><%= Language.GetSite(23) %></span>
                                        <div class="icons d-flex align-items-center">
                                            <a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title) %>"><span class="flaticon-fullscreen"></span></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- aboutUs -->
    <section class="pb-0">
        <div class="container">
            <div class="row align-items-md-center wow fadeInUp" data-wow-delay="300ms">
                <% List<Entities.GeneralRecords> aboutList = StaticList.Records.Where(x => (x.CatID == 9) && (x.Approved == 1)).ToList();
                    foreach (var item in aboutList){ %>
                <div class="col-md-6 col-lg-6">
                    <div class="position-relative mb30-md">
                        <img src="<%= Feature.ImageFolder + Handler.SetImage(item.Image, item._Image) %>" alt="<%= Handler.SetText(item.Title, item._Title) %>" class="w-100" >
                    </div>
                </div>
                <div class="col-md-6 col-lg-5 offset-lg-1 wow fadeInUp" data-wow-delay="500ms">
                    <div class="main-title2">
                        <h2 class="title mb-4"><%= Handler.SetText(item.AdditionalTitle, item._AdditionalTitle) %></h2>
                        <div class="paragraph fz15"><%= Handler.SetText(item.MainContent, item._MainContent) %></div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- services -->
    <section class="pb50-md">
        <div class="container">
            <div class="row align-items-center wow fadeInUp" data-wow-delay="300ms">
                <div class="col-lg-9">
                    <div class="main-title2">
                        <h2 class="title"><%= Language.GetSite(24) %></h2>
                        <p class="paragraph"><%= Language.GetSite(25) %></p>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="text-start text-lg-end mb-3">
                        <a href="<%= Handler.SetMetaURL(7, 5, false)%>" title="<%= Language.GetSite(26) %>" class="ud-btn2">
                            <%= Language.GetSite(26) %><i class="fal fa-arrow-right-long"></i></a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 wow fadeInUp" data-wow-delay="300ms">
                    <div class="property-city-slider dots_none slider-dib-sm slider-4-grid2 vam_nav_style owl-theme owl-carousel">
                        <% List<Entities.GeneralRecords> servicesList = StaticList.Records.Where(x => (x.CatID == 7) && (x.Approved == 1)).ToList();
                            foreach (var item in servicesList) {
                                string recordURL = Handler.SetMetaURL(item.CatID, item.id, true); %>
                        <div class="item">
                            <div class="feature-style1 mb30">
                                <div class="feature-img">
                                    <img src="<%= Feature.ImageFolder + Handler.SetImage(item.Image, item._Image) %>" alt="<%= Handler.SetText(item.Title, item._Title) %>" class="w-100" >
                                </div>
                                <div class="feature-content">
                                    <div class="top-area"><h6 class="title mb-1"><%= Handler.SetText(item.Title, item._Title) %></h6></div>
                                    <div class="bottom-area">
                                        <a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title) %>" class="ud-btn2">
                                            <%= Language.GetSite(23) %><i class="fal fa-arrow-right-long"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- workWithUs -->
    <section class="our-cta bgc-thm-light pt90 pb90 pt60-md pb60-md">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 col-xl-6 wow fadeInLeft" style="visibility: visible; animation-name: fadeInLeft;">
                    <div class="cta-style3">
                        <h2 class="cta-title"><%= Language.GetSite(27) %></h2>
                        <p class="cta-text mb25"><%= Language.GetSite(28) %></p>
                        <a href="<%=  Handler.SetMetaURL(13, 8, false) %>" title="<%= Language.GetSite(29) %>" class="ud-btn btn-thm">
                            <%= Language.GetSite(29) %> <i class="fal fa-arrow-right-long"></i></a>
                    </div>
                </div>
                <div class="col-lg-5 col-xl-4 offset-xl-2 d-none d-lg-block wow fadeIn" data-wow-delay="300ms" style="visibility: visible; animation-delay: 300ms; animation-name: fadeIn;">
                    <div class="cta-img">
                        <img src="/assets/images/about/cta-member-1.png" alt="<%= Language.GetSite(27) %>">
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>
