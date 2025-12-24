<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="WebSite.Partner.Shared.Header" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Entities" %>

<div class="subheader py-3 py-lg-8 subheader-transparent" id="kt_subheader" style="background: #181C32;">
    <div class="container-fluid d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
        <div class="d-flex align-items-center flex-wrap mr-1">
            <a href="/partner/" class="d-flex align-items-baseline flex-wrap mr-5">
                <h2 class="subheader-title text-muted font-weight-bold my-1 mr-3"><%= StaticList.Settings.CompanyName %></h2>
            </a>
        </div>
        <div class="d-flex align-items-center">

            <!-- goToSite -->
            <div class="topbar-item">
                <a href="/" target="_blank" class="btn btn-icon btn-clean btn-lg mr-1">
                    <span class="text-dark svg-icon svg-icon-xl svg-icon-primary">
                        <i class="flaticon-paper-plane"></i>
                    </span>
                </a>
            </div>

            <% if (UserData.id > 0) { %>

            <!-- quit -->
            <div class="topbar-item">
                <a href="<%= Developer.ConstantUrl("logout") %>" title="<%= Language.GetPartner("CikisYap") %>" class="btn btn-icon btn-clean btn-dropdown btn-lg mr-1">
                    <span class="text-dark svg-icon svg-icon-xl svg-icon-primary">
                        <i class="flaticon-close"></i>
                    </span>
                </a>
            </div>

            <!-- user -->
            <div class="topbar-item mr-1">
                <a href="<%= Developer.ConstantUrl("pprofile") %>" title="<%= Language.GetPartner("Profil") %>" class="btn btn-icon w-auto btn-clean d-flex align-items-center btn-lg px-2" id="kt_quick_user_toggle">
                    <span class="text-muted font-weight-bold font-size-base d-none d-md-inline mr-1"><%= Language.GetPartner("Merhaba") %>,</span>
                    <span class="text-dark-50 font-weight-bolder font-size-base d-none d-md-inline mr-3"><%= UserData.Name %></span>
                    <span class="symbol symbol-35 symbol-light-success">
                        <span class="symbol-label font-size-h5 font-weight-bold"><%= UserData.Name.Substring(0, 1) %></span>
                    </span>
                </a>
            </div>
            
            <% } %>

            <!-- languages  -->
            <div class="dropdown">
                <div class="topbar-item" data-toggle="dropdown" data-offset="10px,0px">
                    <div class="btn btn-icon btn-clean btn-dropdown btn-lg mr-1">
                        <img class="h-20px w-20px rounded-sm" src="/raven/assets/flags/<%= (PLanguage == "2" ? "en" : "tr") %>.svg" />
                    </div>
                </div>
                <div class="dropdown-menu p-0 m-0 dropdown-menu-anim-up dropdown-menu-sm dropdown-menu-right">
                    <ul class="navi navi-hover py-4">
                        <li class="navi-item">
                            <a href="javascript:;" onclick="SetPartnerLang('2')" class="navi-link">
                                <span class="symbol symbol-20 mr-3">
                                    <img src="/raven/assets/flags/en.svg" alt="English" />
                                </span>
                                <span class="navi-text">English</span>
                            </a>
                        </li>
                        <li class="navi-item">
                            <a href="javascript:;" onclick="SetPartnerLang('1')" class="navi-link">
                                <span class="symbol symbol-20 mr-3">
                                    <img src="/raven/assets/flags/tr.svg" alt="TR" />
                                </span>
                                <span class="navi-text">Türkçe</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

        </div>

    </div>
</div>