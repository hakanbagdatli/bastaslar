<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="WebSite.Products" %>
<%@ Register Src="~/Shared/LeaseFilter.ascx" TagPrefix="uc1" TagName="LeaseFilter" %>
<%@ Register Src="~/Shared/PageHeader.ascx" TagPrefix="uc1" TagName="PageHeader" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <!-- pageHeader -->
    <uc1:PageHeader ID="PageHeader" runat="server" />
    <uc1:LeaseFilter id="LeaseFilter" runat="server" Visible="false" />

    <!-- properties -->
    <section class="pt0 pb90 bgc-f7">
        <div class="container">
            <div class="row">
                <% foreach (var item in dataList) {
                    string recordURL = Handler.SetMetaURL(item.PageTypeID, item.id, false); %>
                <div class="col-sm-6 col-lg-4">
                    <div class="listing-style1">
                        <div class="list-thumb">
                            <img src="<%= Feature.ImageFolder + Handler.SetImage(item.Image, item._Image) %>" alt="<%= Handler.SetText(item.Title, item._Title) %>" class="w-100" >
                        </div>
                        <div class="list-content">
                            <h6 class="list-title"><a href="<%= recordURL %>" title="<%= Handler.SetText(item.Title, item._Title) %>"><%= Handler.SetText(item.Title, item._Title) %></a></h6>
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
    </section>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>
