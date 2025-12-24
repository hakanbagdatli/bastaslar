<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="WebSite.Raven.Shared.Header" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Entities" %>

<div class="subheader py-3 py-lg-8 subheader-transparent" id="kt_subheader" style="background: #181C32;">
    <div class="container-fluid d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
        <div class="d-flex align-items-center flex-wrap mr-1">
            <div class="d-flex align-items-baseline flex-wrap mr-5">
                <h2 class="subheader-title text-muted font-weight-bold my-1 mr-3"><%= Entities.StaticList.Settings.CompanyName %></h2>
            </div>
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

            <!-- quit -->
            <div class="topbar-item">
                <a href="<%= Developer.ConstantUrl("logout") %>" title="<%# Language.GetFixed("CikisYap") %>" class="btn btn-icon btn-clean btn-dropdown btn-lg mr-1">
                    <span class="text-dark svg-icon svg-icon-xl svg-icon-primary">
                        <i class="flaticon-close"></i>
                    </span>
                </a>
            </div>

            <!-- user -->
            <div class="topbar-item mr-1">
                <div class="btn btn-icon w-auto btn-clean d-flex align-items-center btn-lg px-2" id="kt_quick_user_toggle">
                    <span class="text-muted font-weight-bold font-size-base d-none d-md-inline mr-1"><%= Language.GetFixed("Merhaba") %>,</span>
                    <span class="text-dark-50 font-weight-bolder font-size-base d-none d-md-inline mr-3"><%= Developer.LoggedUser().Name %></span>
                    <span class="symbol symbol-35 symbol-light-success">
                        <span class="symbol-label font-size-h5 font-weight-bold"><%= Developer.LoggedUser().Name.Substring(0, 1) %></span>
                    </span>
                </div>
            </div>

            <!-- languages -->
            <div class="dropdown">
                <div class="topbar-item" data-toggle="dropdown" data-offset="10px,0px">
                    <div class="btn btn-icon btn-clean btn-dropdown btn-lg mr-1">
                        <img class="h-20px w-20px rounded-sm" src="/raven/assets/flags/<%= Feature.CRMLanguage.ToLower() %>.svg" />
                    </div>
                </div>
                <div class="dropdown-menu p-0 m-0 dropdown-menu-anim-up dropdown-menu-sm dropdown-menu-right">
                    <ul class="navi navi-hover py-4">
                        <% List<Entities.zLangCodes> langList = Bll.zLangCodes.Select(0, " AND id in (1,2) AND Approved=1");
                            foreach (var item in langList) { %>
                        <li class="navi-item">
                            <a href="javascript:;" onclick="SetCRMLang('<%= Helper.AllLetterUppercase(item.Code) %>')" class="navi-link">
                                <span class="symbol symbol-20 mr-3">
                                    <img src="/raven/assets/flags/<%= item.Flags %>" alt="<%= item.Title %>" />
                                </span>
                                <span class="navi-text"><%= item.Title %></span>
                            </a>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>

        </div>

    </div>
</div>