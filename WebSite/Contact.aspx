<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WebSite.Contact" %>
<%@ Register Src="~/Shared/PageHeader.ascx" TagPrefix="uc1" TagName="PageHeader" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <!-- pageHeader -->
    <uc1:PageHeader ID="PageHeader" runat="server" Visible="false" />

    <!-- map -->
    <section class="p-0">
        <% foreach (var item in contactList) { %>
        <iframe class="home8-map contact-page" loading="lazy" src="<%= item.GoogleMap %>" title="<%= item.BranchName %>" aria-label="<%= item.Address %>"></iframe>
        <% } %>
    </section>

    <!-- form -->
    <section>
        <div class="container">
            <div class="row d-flex align-items-end">
                <div class="col-lg-5 position-relative">
                    <div class="home8-contact-form default-box-shadow1 bdrs12 bdr1 p30 mb30-md bgc-white">
                        <h4 class="form-title mb25"><%= Language.GetSite(34) %></h4>
                        <div class="form-style1">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="mb20">
                                        <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(35) %></label>
                                        <input type="text" id="FirstName" data-field="First Name" placeholder="<%= Language.GetSite(35) %>" class="form-control cnt-form-data" required />
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="mb20">
                                        <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(36) %></label>
                                        <input type="text" id="LastName" data-field="Last Name" placeholder="<%= Language.GetSite(36) %>" class="form-control cnt-form-data" required />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="mb20">
                                        <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(6) %></label>
                                        <input type="email" id="Email" data-field="Email" class="form-control cnt-form-data" placeholder="<%= Language.GetSite(6) %>" required />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="mb20">
                                        <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(37) %></label>
                                        <select id="Subject" data-field="Subject" class="form-control cnt-form-data" placeholder="<%= Language.GetSite(37) %>" required>
                                            <option><%= Language.GetSite(38) %></option>
                                            <option><%= Language.GetSite(39) %></option>
                                            <option><%= Language.GetSite(40) %></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="mb10">
                                        <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(41) %></label>
                                        <textarea id="Message" data-field="Message" class="cnt-form-data" cols="30" rows="4" placeholder="<%= Language.GetSite(41) %>" required></textarea>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="d-grid">
                                        <a href="javascript:;" title="<%= Language.GetSite(42) %>" data-prefix="cnt" data-formid="1" class="ud-btn btn-thm btn-send-data">
                                            <%= Language.GetSite(42) %><i class="fal fa-arrow-right-long"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 offset-lg-1">
                    <h2 class="mb30 text-capitalize"><%= Language.GetSite(43) %></h2>
                    <p class="text"><%= Language.GetSite(44) %></p>
                </div>
            </div>
        </div>
    </section>

    <!-- information -->
    <section class="pt0 pb90 pb10-md">
        <div class="container">
            <div class="row">
                <% foreach (var item in contactList) { %>
                <div class="col-sm-6 col-lg-4 wow fadeInLeft" data-wow-delay="00ms" style="visibility: visible; animation-delay: 0ms; animation-name: fadeInLeft;">
                    <div class="iconbox-style8 text-center">
                        <div class="icon">
                            <img src="/assets/images/telephone.png" alt="<%= Language.GetSite(45) %>">
                        </div>
                        <div class="iconbox-content">
                            <h4 class="title"><%= Language.GetSite(45) %></h4>
                            <p class="text mb-1"><%= item.Phone + " " + Language.GetSite(2) %></p>
                            <%= !String.IsNullOrEmpty(item.Gsm) ? "<p class='text mb-1'>" + item.Gsm + " " + Language.GetSite(3) + "</p>" : "" %>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-4 wow fadeInUp" data-wow-delay="300ms" style="visibility: visible; animation-delay: 300ms; animation-name: fadeInUp;">
                    <div class="iconbox-style8 active text-center">
                        <div class="icon">
                            <img src="/assets/images/email.png" alt="<%= Language.GetSite(46) %>">
                        </div>
                        <div class="iconbox-c1ontent">
                            <h4 class="title"><%= Language.GetSite(46) %></h4>
                            <p class="text mb-1"><%= item.Email + " " + Language.GetSite(2) %></p>
                            <%= !String.IsNullOrEmpty(item.Email2) ? "<p class='text mb-1'>" + item.Email2 + " " + Language.GetSite(3) + "</p>" : "" %>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-4 wow fadeInRight" data-wow-delay="300ms" style="visibility: visible; animation-delay: 300ms; animation-name: fadeInRight;">
                    <div class="iconbox-style8 text-center">
                        <div class="icon">
                            <img src="/assets/images/placeholder.png" alt="<%= Language.GetSite(47) %>">
                        </div>
                        <div class="iconbox-content">
                            <h4 class="title"><%= Language.GetSite(47) %></h4>
                            <p class="text mb-1"><%= item.Address %></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>