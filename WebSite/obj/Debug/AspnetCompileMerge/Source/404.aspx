<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="WebSite._404" %>
<%@ Register Src="~/Shared/PageHeader.ascx" TagPrefix="uc1" TagName="PageHeader" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <!-- pageHeader -->
    <uc1:PageHeader runat="server" ID="PageHeader" Visible="false" />

    <!-- pageContent -->
    <section class="our-error">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-xl-6 wow fadeInRight" data-wow-delay="300ms" style="visibility: visible; animation-delay: 300ms; animation-name: fadeInRight;">
                    <div class="animate_content text-center text-xl-start">
                        <div class="animate_thumb" style="transform: perspective(500px) translateZ(0px) rotateX(5.01983deg) rotateY(-3.08799deg); transition: none;">
                            <img src="/assets/images/icon/error-page-img.svg" alt="<%= Language.GetSite(30) %>" class="w-100" >
                        </div>
                    </div>
                </div>
                <div class="col-xl-5 offset-xl-1 wow fadeInLeft" data-wow-delay="300ms" style="visibility: visible; animation-delay: 300ms; animation-name: fadeInLeft;">
                    <div class="error_page_content mt80 mt50-lg text-center text-xl-start">
                        <div class="erro_code"><span class="text-thm">40</span>4</div>
                        <div class="h2 error_title"><%= Language.GetSite(31) %></div>
                        <p class="text fz15 mb20"><%= Language.GetSite(32) %></p>
                        <a href="<%= Handler.GetLanguageMain() %>" title="<%= Language.GetSite(33) %>" class="ud-btn btn-dark">
                            <%= Language.GetSite(33) %><i class="fal fa-arrow-right-long"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>