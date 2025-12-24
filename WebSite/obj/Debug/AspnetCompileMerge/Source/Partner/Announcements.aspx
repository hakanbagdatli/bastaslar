<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="WebSite.Partner.Announcements" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

                <!-- header -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-header flex-wrap py-3">
                        <div class="card-title">
                            <div class="d-block text-muted pt-2 font-size-sm">
                                <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                                    <li class="breadcrumb-item"><a href="/partner/" class="text-muted"><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= Language.GetPartner("Duyurular") %></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-toolbar">
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetPartner("GeriDon") %></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- body -->
                <% var defines = StaticList.Defines.Where(x => x.CatID == 8);
                    if (UserData.CatID != 1)
                        defines = defines.Where(x => x.forSales == 0);

                foreach (var item in defines) { %>
                <div class="card card-custom gutter-b">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="symbol symbol-40 symbol-light-secondary mr-5">
                                <span class="symbol-label">
                                    <img src="<%= Feature.ImageFolder + StaticList.Settings.Favicon %>" class="h-75" alt="<%= StaticList.Settings.CompanyName %>">
                                </span>
                            </div>
                            <div class="d-flex flex-column flex-grow-1">
                                <a href="#" class="text-dark-75 text-hover-primary mb-1 font-size-lg font-weight-bolder"><%= item.Title %></a>
                                <span class="text-muted font-weight-bold"><%= Helper.DatewithCulture(item.CreatedDate.ToString(), PLanguage) %></span>
                            </div>
                        </div>
                        <div class="pt-5">
                            <p class="text-dark-75 font-size-lg font-weight-normal mb-2"><%= item.Description %></p>
                            <% if (!String.IsNullOrEmpty(item.Filename) || item.FileTypeID == 6) { %>
                            <a href="<%= item.FileTypeID == 6 ? item.Description : Feature.ReportFileFolder + item.Filename %>" target="_blank" class="btn btn-success btn-shadow-hover font-weight-bolder w-100 py-3 my-5">
                                <%= Language.GetPartner("DosyaAc") %></a>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% } %>
               

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>
