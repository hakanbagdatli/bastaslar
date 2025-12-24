<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Records.aspx.cs" Inherits="WebSite.Records" %>
<%@ Register Src="~/Shared/PageHeader.ascx" TagPrefix="uc1" TagName="PageHeader" %>
<%@ Register Src="~/Shared/LeaseFilter.ascx" TagPrefix="uc1" TagName="LeaseFilter" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <!-- pageHeader -->
    <uc1:PageHeader ID="PageHeader" runat="server" />
    <uc1:LeaseFilter runat="server" ID="LeaseFilter" Visible="false" />

    <!-- withImage -->
    <section id="pnlWithImage" runat="server" visible="false" class="our-blog">
        <div class="container">
            <div class="row wow fadeInUp" data-wow-delay="300ms">
                <div class="col-xl-12">
                    <div class="navpill-style1">
                        <div class="row">
                            <% foreach (var item in dataList) {
                                string recordURL = Handler.SetMetaURL(item.CatID, item.id, true); %>
                            <div class="col-sm-6 col-lg-4">
                                <div class="blog-style1">
                                    <div class="blog-img">
                                        <img src="<%= Feature.ImageFolder + Handler.SetImage(item.Image, item._Image) %>" alt="<%= Handler.SetText(item.Title, item._Title) %>" class="w-100" />
                                    </div>
                                    <div class="blog-content">
                                        <h6 class="title mt-1"><a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title) %>">
                                            <%= Handler.SetText(item.Title, item._Title) %></a></h6>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- projects -->
    <section id="pnlProjects" runat="server" visible="false" class="our-blog">
        <div class="container">
            <div class="row wow fadeInUp" data-wow-delay="300ms">
                <div class="col-xl-12">
                    <div class="navpill-style1">
                        <div class="row">
                            <% foreach (var item in dataList) {
                                string recordURL = Handler.SetMetaURL(item.CatID, item.id, true); %>
                            <div class="col-sm-6 col-lg-4">
                                <div class="listing-style1">
                                    <div class="list-thumb">
                                        <img src="<%= Feature.ImageFolder + Handler.SetImage(item.Image, item._Image) %>" alt="<%= Handler.SetText(item.Title, item._Title)  %>" class="w-100" >
                                    </div>
                                    <div class="list-content">
                                        <h6 class="list-title"><a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title)  %>">
                                            <%= Handler.SetText(item.Title, item._Title)  %></a></h6>
                                        <p class="list-text"><%= item._CategoryName %></p>
                                        <hr class="mt-2 mb-2">
                                        <div class="list-meta2 d-flex justify-content-between align-items-center">
                                            <span class="for-what"><%= Language.GetSite(23) %></span>
                                            <div class="icons d-flex align-items-center">
                                                <a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title)  %>"><span class="flaticon-fullscreen"></span></a>
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
        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>