<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sidebar.ascx.cs" Inherits="WebSite.Raven.Shared.Sidebar" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>

<div id="kt_aside" class="aside aside-left d-flex aside-fixed">
    <div class="aside-primary d-flex flex-column align-items-center flex-row-auto">

        <!-- logo-->
        <div class="aside-brand d-flex flex-column align-items-center flex-column-auto py-5 py-lg-12">
            <a href="<%= Developer.ConstantUrl("dashboard") %>" title="Liophin Software">
                <img src="/raven/assets/media/logo.png" alt="Liophin Software Logo" class="max-h-30px" />
            </a>
        </div>

        <!-- wrapper-->
        <div class="aside-nav d-flex flex-column align-items-center flex-column-fluid py-5 scroll scroll-pull">
            <ul class="nav flex-column" role="tablist">
                <li class="nav-item mb-3" data-original-title="<%= Language.GetFixed("Anasayfa") %>">
                    <a href="/raven/dashboard" class="nav-link btn btn-icon btn-clean btn-lg">
                        <i class="icon-2x flaticon-squares-4"></i>
                    </a>
                </li>
                <%  List<Entities.zMenus> mainList = Bll.zMenus.Select(0, " AND can" + Developer.UserToken("")._Statu + "=1 AND CatID=0 AND Approved=1", "Sorting ASC");
                    foreach (var item in mainList) { %>
                <li class="nav-item mb-3" data-toggle="tooltip" data-placement="right" data-container="body" data-boundary="window" title="<%= Language.GetFixed(item.LangID) %>" data-id="<%= item.id %>">
                    <a href="#" class="nav-link btn btn-icon btn-clean btn-lg<%= item.id == 1 ? " active" : "" %>" data-toggle="tab" data-target="#aside_tab<%= item.id %>" role="tab">
                        <i class="icon-2x <%= item.Icon %>"></i>
                    </a>
                </li>
                <%} %>
            </ul>
        </div>

        <!-- footer -->
        <div class="aside-footer d-flex flex-column align-items-center flex-column-auto py-4 py-lg-10">
            <span class="aside-toggle btn btn-icon btn-warning btn-hover-warning shadow-sm" id="kt_aside_toggle" data-toggle="tooltip" data-placement="right" data-container="body" data-boundary="window" title="Toggle Aside">
                <i class="ki ki-bold-arrow-back icon-sm"></i>
            </span>
            <a href="<%= Developer.ConstantUrl("logout") %>" class="btn btn-icon btn-clean btn-lg mb-1" id="kt_quick_actions_toggle" data-toggle="tooltip" data-placement="right" data-container="body" data-boundary="window" title="Logout">
                <span class="svg-icon svg-icon-xl">
                    <i class="icon-2x flaticon-logout"></i>
                </span>
            </a>
        </div>

    </div>

    <!-- secondary-->
    <div class="aside-secondary d-flex flex-row-fluid">
        <div class="aside-workspace scroll scroll-push my-2">
            <div class="tab-content">
                <%  foreach (var main in mainList) { %>
                <div class="tab-pane p-3 px-lg-7 py-lg-5 fade<%= main.id == 1 ? " show active" : "" %>" id="aside_tab<%= main.id %>">
                    <h4 class="p-2 p-lg-3 my-1 my-lg-3"><%= Language.GetFixed(main.LangID) %></h4>
                    <% List<Entities.zMenus> dList = Bll.zMenus.Select(0, " AND can" + Developer.UserToken("")._Statu + "=1 AND CatID=" + main.id + " AND Approved=1", "Sorting ASC, id ASC"); %>
                    <div class="list list-hover">
                        <% foreach (var item in dList) { %>
                            <div class="list-item hoverable p-2 p-lg-3 mb-2">
                                <div class="d-flex align-items-center">
                                    <div class="symbol symbol-40 symbol-light mr-4"><i class="menu-icon <%= !String.IsNullOrEmpty(item.Icon) ? item.Icon : "flaticon-menu-1" %>"></i></div>
                                    <div class="d-flex flex-column flex-grow-1 mr-2">
                                        <a href="<%= !String.IsNullOrEmpty(item.Link) ? "/raven" + item.Link : "javascript:;" %>" class="text-dark-75 font-size-h6 mb-0"><%= Language.GetFixed(item.LangID) %></a>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>

</div>
