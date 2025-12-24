<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebSite.Raven.Users.Profile" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">
    <div class="d-flex flex-column-fluid">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-custom gutter-b example example-compact">

                        <!-- header -->
                        <div class="card-header flex-wrap py-3">
                            <div class="card-title">
                                <div class="d-block text-muted pt-2 font-size-sm">
                                    <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                                        <asp:Literal ID="ltrTree" runat="server" />
                                    </ul>
                                </div>
                            </div>
                            <div class="card-toolbar">
                                <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                    <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                                    <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                                </div>
                            </div>
                        </div>

                        <!-- body -->
                        <div class="card-body">
                            <input id="table" class="form-control" type="hidden" value="22" />
                            <input id="id" class="form-control form-data" type="hidden" value="<%= UserID %>" />
                            <% List<Entities.zUsers> dList = Bll.zUsers.Select(UserID, filter: "");
                                foreach (var item in dList) { %>
                                <div class="form-group">
                                    <label><%= Language.GetFixed("Ad") %></label>
                                    <input id="Name" class="form-control form-data" type="text" value="<%= item.Name %>" />
                                </div>
                                <div class="form-group">
                                    <label><%= Language.GetFixed("Soyad") %></label>
                                    <input id="Surname" class="form-control form-data" type="text" value="<%= item.Surname %>" />
                                </div>
                                <div class="form-group">
                                    <label><%= Language.GetFixed("Email") %></label>
                                    <input id="Email" class="form-control form-data" type="text" value="<%= item.Email %>" />
                                </div>
                                <div class="form-group">
                                    <label><%= Language.GetFixed("Telefon") %></label>
                                    <input id="Phone" class="form-control form-data" type="text" value="<%= item.Phone %>" />
                                </div>
                                <div class="form-group">
                                    <label><%= Language.GetFixed("Sifre") %></label>
                                    <input id="Password" class="form-control form-data" type="password" autocomplete="off" />
                                </div>
                            <% } %>
                        </div>

                        <!-- footer -->
                        <div class="card-footer">
                            <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                            <a href="javascript:;" class="btn btn-secondary font-weight-bold" onclick="window.history.back()">&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server"></asp:Content>