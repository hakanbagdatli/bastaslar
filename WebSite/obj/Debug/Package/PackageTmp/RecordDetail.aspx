<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="RecordDetail.aspx.cs" Inherits="WebSite.RecordDetail" %>
<%@ Register Src="~/Shared/PageHeader.ascx" TagPrefix="uc1" TagName="PageHeader" %>
<%@ Register Src="~/Shared/JobApplication.ascx" TagPrefix="uc1" TagName="JobApplication" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <!-- pageHeader -->
    <uc1:PageHeader ID="PageHeader" runat="server" />

    <% foreach (var item in dataList)  { 
        if (!String.IsNullOrEmpty(item.MainContent)) { %>
    <section data-anim="slide-up" class="layout-pt-md layout-pb-md">
        <div class="container">
            <div class="row y-gap-30 justify-center">
                <div class="col-xl-12 col-lg-12">
                    <div class="text-area text-15 mt-20">
                        <%= Handler.SetText(item.MainContent, item._MainContent) %>
                    </div>
                    <uc1:JobApplication ID="JobApplication"  runat="server" Visible="false" />
                </div>
            </div>
        </div>
    </section>
    <% }  } %>


    <% if (featureList.Count > 0) { %>
    <section class="layout-pt-md layout-pb-md">
        <div class="container">
            <div class="row y-gap-30 justify-center pt-40 sm:pt-20">
                <div class="accordion -simple row y-gap-20 js-accordion">
                    <% int featureCount = 0;
                        foreach (var item in featureList) { %>
                    <div class="col-12">
                        <div class="accordion__item px-20 py-20 border-light rounded-4<%= featureCount == 0 ? " is-active" : "" %>">
                            <div class="accordion__button d-flex items-center">
                                <div class="accordion__icon size-40 flex-center bg-light-2 rounded-full mr-20">
                                    <i class="icon-plus"></i>
                                    <i class="icon-minus"></i>
                                </div>
                                <div class="button text-dark-1">
                                    <%= item.Title %>
                                </div>
                            </div>
                            <div class="accordion__content"<%= featureCount == 0 ? "style='max-height: 134px;'" : ""%>>
                                <div class="pt-20 pl-60">
                                    <p class="text-15"><%= item.ShortContent %> </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% featureCount++; } %>
                </div>
            </div>
        </div>
    </section>
    <% } %>

    <% if (photoList.Count > 0) { %>
    <section class="layout-pt-md layout-pb-md">
        <div class="container">
            <div class="row y-gap-30 justify-center pt-40 sm:pt-20">
                <% foreach (var item in photoList) { %>
                <div class="col-md-4 mb-4">
                    <a href="<%= Feature.ImageFolder + item.Image %>" title="<%= item.Title %>" class="popup-img preview-img-1 sp-img">
                        <img src="<%= Feature.ImageFolder + item.Image %>" alt="<%= item.Title %>" class="w-100" />
                    </a>
                </div>
                <% } %>
            </div>
        </div>
    </section>
    <% } %>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>