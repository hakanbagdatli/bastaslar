<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="MarketInsights.aspx.cs" Inherits="WebSite.Partner.MarketInsights" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>

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
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= Language.GetPartner("PazarBilgileri") %></a></li>
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
                <div class="row">
                    <% foreach (var item in Entities.StaticList.Defines.Where(x => (x.CatID == 6))) { %>
                    <div class="col-xl-4">
                        <div class="card card-custom gutter-b card-stretch">
                            <div class="card-body d-flex flex-column">
                                <div class="flex-grow-1 text-center pt-5 pb-5">
                                    <a href="<%= Feature.FileFolder + item.Filename %>" title="<%= item.Title %>">
                                        <img src="/raven/assets/media/files/<%= item.FileTypeID %>.svg" alt="<%= item.Title %>" class="w-50" />
                                    </a>
                                </div>
                                <div class="pt-5">
                                    <h5 class="text-center font-weight-bolder"><%= item.Title %></h5>
                                    <p class="text-center font-weight-normal font-size-lg pb-7"><%= item.Description %></p>
                                    <a href="<%= Feature.FileFolder + item.Filename %>" class="btn btn-success btn-shadow-hover font-weight-bolder w-100 py-3">
                                        <%= Language.GetPartner("DosyaAc") %></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }  %>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>
