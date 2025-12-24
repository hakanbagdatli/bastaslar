<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="WebSite.ProductDetail" %>
<%@ Register Src="~/Shared/PageHeader.ascx" TagPrefix="uc1" TagName="PageHeader" %>
<%@ Register Src="~/Shared/RightAside.ascx" TagPrefix="uc1" TagName="RightAside" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <!-- pageHeader -->
    <uc1:PageHeader ID="PageHeader" runat="server" Visible="false" />

    <!-- detail -->
    <section class="pt60 pb90 bgc-white">
        <div class="container">

            <% if (isProperty == false) { %>

            <!-- entrance -->
            <div class="row wow fadeInUp" data-wow-delay="100ms">
                <% foreach (var item in dataList) { %>
                <div class="col-lg-12">
                    <div class="single-property-content mb30-md">
                        <h2 class="sp-lg-title"><%= Handler.SetText(item.Title, item._Title) %></h2>
                        <div class="pd-meta mb15 d-md-flex align-items-center">
                            <p class="text fz15 pr10 mb-0 bdrr1 bdrrn-sm">For sale</p>
                            <p class="text fz15 pr10 mb-0 ml0-sm ml10"><%= Handler.SetText(item._CategoryName, "") %></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- images -->
            <div class="row mb30 mt30 wow fadeInUp" data-wow-delay="300ms">
                <div class="col-sm-6">
                    <div class="sp-img-content mb15-lg">
                        <% foreach (var item in photoList.Take(1)) { %>
                        <a href="<%= Feature.ImageFolder + item.Image %>" title="<%= item.Title %>" class="popup-img sp-v3 sp-img preview-img-<%= item.id %> sp-img">
                            <img src="<%= Feature.ImageFolder + item.Image %>" alt="<%= item.Title %>" class="w-100" />
                        </a>
                        <% } %>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="row">
                        <% int imageCount = 0;
                            foreach (var item in photoList.Skip(1)) { %>
                        <div class="col-4 ps-sm-0<%= imageCount > 8 ? " d-none" : "" %>">
                            <div class="sp-img-content">
                                <a href="<%= Feature.ImageFolder + item.Image %>" title="<%= item.Title %>" class="popup-img preview-img sp-img mb10">
                                    <img src="<%= Feature.ImageFolder + item.Image %>" alt="<%= item.Title %>" class="w-100">
                                </a>
                                <%= imageCount == 9 ? "<a href='" + Feature.ImageFolder + item.Image +"' title='See All' class='all-tag style2 popup-img'>" + photoList.Count +"+</a>" : "" %>
                            </div>
                        </div>
                        <% imageCount++; } %>
                    </div>
                </div>
            </div>
            
            <% } else { %>
            
            <!-- entrance -->
            <div class="row wow fadeInUp" data-wow-delay="100ms">
                <% foreach (var item in planDetail) { %>
                <div class="col-lg-8">
                    <div class="single-property-content mb30-md">
                        <h2 class="sp-lg-title"><%= item.Title %></h2>
                        <div class="pd-meta mb15 d-md-flex align-items-center">
                            <p class="text fz15 mb-0 bdrr1 pr10 bdrrn-sm">For sale</p>
                            <p class="text fz15 mb-0 bdrr1 pl10 pr10 bdrrn-sm"><%= item._CategoryName %></p>
                            <p class="text fz15 mb-0 pl10"><%= item.PropertyID %></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="single-property-content">
                        <div class="property-action text-lg-end">
                            <h3 class="price mb-0"><%= item.PropertyPrice %></h3>
                            <div class="property-meta d-flex align-items-center justify-content-sm-end">
                                <span class="text fz15"><i class="flaticon-bed pe-2 align-text-top"></i><%= item.PropertyBedroom %> bed</span>
                                <span class="text ml20 fz15"><i class="flaticon-shower pe-2 align-text-top"></i><%= item.PropertyBath %> bath</span>
                                <span class="text ml20 fz15"><i class="flaticon-expand pe-2 align-text-top"></i><%= item.PropertySize %> m<sup>2</sup></span>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            
            <!-- images -->
            <div class="row mt30 mb50 wow fadeInUp" data-wow-delay="300ms">
                <div class="col-sm-9">
                    <div class="sp-img-content at-sp-v2 mb15-md">
                        <% foreach (var item in photoList.Take(1)) { %>
                        <a href="<%= Feature.ImageFolder + item.Image %>" title="<%= item.Title %>" class="popup-img sp-img preview-img-<%= item.id %>">
                            <img src="<%= Feature.ImageFolder + item.Image %>" alt="<%= item.Title %>" class="w-100" />
                        </a>
                        <% } %>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="row">
                        <% int imageCount = 0;
                            foreach (var item in photoList.Skip(1)) { %>
                        <div class="col-sm-12 ps-lg-0<%= imageCount > 2 ? " d-none" : "" %>">
                            <div class="sp-img-content">
                                <a href="<%= Feature.ImageFolder + item.Image %>" title="<%= item.Title %>" class="popup-img preview-img sp-img mb10">
                                    <img src="<%= Feature.ImageFolder + item.Image %>" alt="<%= item.Title %>" class="w-100">
                                </a>
                                <%= imageCount == 2 ? "<a href='" + Feature.ImageFolder + item.Image +"' title='See All' class='all-tag popup-img'>See All " + photoList.Count +" Photos+</a>" : "" %>
                            </div>
                        </div>
                        <% imageCount++; } %>
                    </div>
                </div>
            </div>

            <% } %>

            <!-- content -->
            <div class="row wrap wow fadeInUp" data-wow-delay="500ms">
                <div class="col-lg-8">

                    
                    <% if (isProperty == false) { %>
                    <!-- overview -->
                    <div class="ps-widget mb30 overflow-hidden position-relative">
                        <h4 class="title fz17 mb30"><%= Language.GetSite(48) %></h4>
                        <div class="row">
                            <% foreach (var item in dataList) { %>
                            <div class="col-sm-6 col-lg-4">
                                <div class="overview-element mb25 d-flex align-items-center">
                                    <span class="icon flaticon-bed"></span>
                                    <div class="ml15">
                                        <h6 class="mb-0"><%= Language.GetSite(49) %></h6>
                                        <p class="text mb-0 fz15"><%= item.PropertyFlatCount %></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-4">
                                <div class="overview-element mb25-xs d-flex align-items-center">
                                    <span class="icon flaticon-expand"></span>
                                    <div class="ml15">
                                        <h6 class="mb-0"><%= Language.GetSite(50) %></h6>
                                        <p class="text mb-0 fz15"><%= item.PropertySize %> m<sup>2</sup> </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-4">
                                <div class="overview-element mb25-xs d-flex align-items-center">
                                    <span class="icon flaticon-garage"></span>
                                    <div class="ml15">
                                        <h6 class="mb-0"><%= Language.GetSite(51) %></h6>
                                        <p class="text mb-0 fz15"><%= item.PropertyEndDate %></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-4">
                                <div class="overview-element d-flex align-items-center">
                                    <span class="icon flaticon-home-1"></span>
                                    <div class="ml15">
                                        <h6 class="mb-0"><%= Language.GetSite(52) %></h6>
                                        <p class="text mb-0 fz15"><%=item._PropertyStatu %></p>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    <% } %>

                    <!-- description -->
                    <div class="ps-widget bdrb1 pb30 mb30 overflow-hidden position-relative">
                        <% if (isProperty == false) {  
                            foreach (var item in dataList) { %>
                        <h4 class="title fz17 mb30"><%= Language.GetSite(53) %></h4>
                        <div class="text mb10"><%= Handler.SetText(item.MainContent, item._MainContent) %></div>
                        <% }  } else { 
                            foreach (var item in planDetail) { %>
                        <h4 class="title fz17 mb30"><%= Language.GetSite(54) %></h4>
                        <div class="text mb10"><%= Handler.SetText(item.MainContent, "") %></div>
                        <% }  } %>
                    </div>

                    <!-- features -->
                    <% foreach (var item in featureList) { %>
                    <div class="d-grid accordion-style2 bdrb1 pb25">
                        <div class="accordion" id="accordion<%= item.id %>">
                            <div class="accordion-item border-none bgc-transparent">
                                <h2 class="accordion-header" id="heading<%= item.id %>">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%= item.id %>" aria-expanded="true" aria-controls="collapse<%= item.id %>">
                                        <%= item.Title %></button>
                                </h2>
                                <div id="collapse<%= item.id %>" class="accordion-collapse collapse" aria-labelledby="heading<%= item.id %>" data-bs-parent="#accordion<%= item.id %>">
                                    <div class="accordion-body">
                                        <div class="text features-list">
                                            <%= item.MainContent %>
                                            <%= !String.IsNullOrEmpty(item.ShortContent) ? "<iframe class='position-relative bdrs12 mt30 h250' loading='lazy' src='" + item.ShortContent + "'></iframe>" : "" %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>

                    <!-- videos -->
                    <div id="pnlVideos" runat="server" visible="false" class="accordion-style2 bdrb1 pb25">
                        <div class="accordion" id="accordionVideo">
                            <div class="accordion-item border-none bgc-transparent">
                                <h2 class="accordion-header" id="headingVideo">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseVideo" aria-expanded="true" aria-controls="collapseVideo"><%= Language.GetSite(55) %></button>
                                </h2>
                                <div id="collapseVideo" class="accordion-collapse collapse" aria-labelledby="headingVideo" data-bs-parent="#accordionVideo">
                                    <div class="accordion-body">
                                        <div class="row">
                                            <% foreach (var item in videoList) { %>
                                            <div class="col-md-12">
                                                <div class="property_video bdrs12 w-100">
                                                    <a href="<%= item.VideoEmbed %>" title="<%= item.Title %>" class="video_popup_btn mx-auto popup-img popup-youtube">
                                                        <span class="flaticon-play"></span></a>
                                                </div>
                                            </div>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- rightAside -->
                <uc1:RightAside runat="server" ID="RightAside" />

            </div>

            <!-- properties 
            <div id="pnlPlans" runat="server" Visible="false" class="row mt30 wow fadeInUp" data-wow-delay="700ms">
                <div class="col-lg-9">
                    <div class="main-title2">
                        <h2 class="title">Properties</h2>
                        <p class="paragraph">Aliquam lacinia diam quis lacus euismod</p>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="property-city-slider navi_pagi_top_right slider-dib-sm slider-3-grid owl-theme owl-carousel">
                        <% foreach (var item in planList) {
                           string propertyURL = "?property=true&v=" + item.PropertyID; %>
                        <div class="item">
                            <div class="listing-style1">
                                <div class="list-thumb">
                                    <a href="<%= propertyURL %>" title="<%= item.Title %>">
                                        <img src="<%= Feature.ImageFolder + item.Image %>" alt="<%= item.Title %>" class="w-100" />
                                    </a>
                                </div>
                                <div class="list-content">
                                    <h6 class="list-title"><a href="<%= propertyURL %>" title="<%= item.Title %>"><%= item.Title %></a></h6>
                                    <p class="list-text"><%= item._CategoryName %></p>
                                    <div class="list-meta d-flex align-items-center">
                                        <a href="<%= propertyURL %>" title="Bed"><span class="flaticon-bed"></span><%= item.PropertyBedroom %> bed</a>
                                        <a href="<%= propertyURL %>" title="Bath"><span class="flaticon-shower"></span><%= item.PropertyBath %> bath</a>
                                        <a href="<%= propertyURL %>" title="Bed"><span class="flaticon-expand"></span><%= item.PropertySize %> m<sup>2</sup></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div> -->

        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script>
        //  Fixed sidebar Custom Script For That 
        $(function () {
            var cols = $('.wrap .column');
            var enabled = true;
            var scrollbalance = new ScrollBalance(cols, {
                minwidth: 0
            });
            // bind to scroll and resize events
            scrollbalance.bind();
        });
    </script>
</asp:Content>