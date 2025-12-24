<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebSite.About" %>
<%@ Register Src="~/Shared/PageHeader.ascx" TagPrefix="uc1" TagName="PageHeader" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <!-- pageHeader -->
    <uc1:PageHeader runat="server" ID="PageHeader" />
    
    <!-- pageContent -->
    <section class="layout-pt-md layout-pb-md">
        <div class="container">
            <div class="row y-gap-30 justify-between items-center">
                <% foreach (var item in dataList) { %>
                <div class="col-lg-5">
                    <%= Handler.SetText(item.MainContent, item._MainContent) %>
                </div>
                <div class="col-lg-6">
                    <img src="<%= Feature.ImageFolder + Handler.SetImage(item.Image, item._Image) %>" alt="<%= Handler.SetText(item.Title, item._Title) %>" class="rounded-4" />
                </div>
                <% } %>
            </div>
        </div>
    </section>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>