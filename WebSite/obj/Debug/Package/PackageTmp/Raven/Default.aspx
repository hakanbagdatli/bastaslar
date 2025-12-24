<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebSite.Raven.Default" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Site Yönetim Paneli</title>
    <link rel="shortcut icon" href="/raven/assets/media/favicon.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" />
    <link href="/raven/assets/css/page.login.css" rel="stylesheet" type="text/css" />
    <link href="/raven/assets/css/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
    <link href="/raven/assets/css/plugins.bundle.css" rel="stylesheet" type="text/css" />
    <link href="/raven/assets/css/prismjs.bundle.css" rel="stylesheet" type="text/css" />
    <link href="/raven/assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
</head>
<body id="kt_body" class="header-mobile-fixed subheader-enabled aside-enabled aside-fixed aside-secondary-enabled page-loading">
    <form id="form1" runat="server">

        <div class="d-flex flex-column flex-root">
            <div class="login login-1 login-signin-on d-flex flex-column flex-lg-row flex-column-fluid bg-white" id="kt_login" style="min-height: 100vh;">

                <!-- aside -->
                <div class="login-aside d-flex flex-column flex-row-auto" style="background-color: #02081e;">
                    <div class="aside-img d-flex flex-row-fluid bgi-no-repeat bgi-position-y-bottom bgi-position-x-center" style="background-image: url(assets/media/intro.jpg);background-size: contain;"></div>
                </div>

                <!-- content -->
                <div class="login-content flex-row-fluid d-flex flex-column justify-content-center position-relative overflow-hidden p-7 mx-auto">
                    <div class="d-flex flex-column-fluid flex-center">

                        <!-- signin-->
                        <div class="login-form login-signin">
                            <div class="form" id="kt_login_signin_form">
                                <div class="pb-13 pt-lg-0 pt-5">
                                    <h3 class="font-weight-bolder text-dark font-size-h4 font-size-h1-lg"><%= Language.GetFixed("GirisYap") %></h3>
                                    <span class="text-muted font-weight-bold font-size-h4"><%= Language.GetFixed("KullaniciAdiSifre") %></span>
                                </div>
                                <div class="form-group">
                                    <label class="font-size-h6 font-weight-bolder text-dark"><%= Language.GetFixed("Email") %></label>
                                    <input class="form-control form-control-solid h-auto py-7 px-6 rounded-lg" type="Email" placeholder="<%= Language.GetFixed("Email") %>" id="username">
                                </div>
                                <div class="form-group">
                                    <label class="font-size-h6 font-weight-bolder text-dark"><%= Language.GetFixed("Sifre") %></label>
                                    <input class="form-control form-control-solid h-auto py-7 px-6 rounded-lg" type="Password" placeholder="<%= Language.GetFixed("Sifre") %>" id="password" autocomplete="off">
                                </div>
                                <div class="form-group d-flex flex-wrap justify-content-between align-items-center mt-3">
                                    <div class="checkbox-inline">
                                        <label class="checkbox checkbox-outline m-0 text-muted">
                                            <input id="ckRemember" type="checkbox">
                                            <span></span><%= Language.GetFixed("BeniHatırla") %></label>
                                    </div>
                                    <a href="javascript:;" id="kt_login_forgot" class="text-muted text-hover-primary"><%= Language.GetFixed("SifremiUnuttum") %></a>
                                </div>
                                <div class="pb-lg-0 pb-5">
                                    <a href="javascript:;" class="btn btn-primary btn-login font-weight-bolder font-size-h6 px-8 py-4 my-3 mr-3"><%= Language.GetFixed("GirisYap") %></a>
                                </div>
                            </div>
                        </div>

                        <!-- forgotPassword -->
                        <div class="login-form login-forgot">
                            <div class="form" id="kt_login_forgot_form">
                                <div class="pb-13 pt-lg-0 pt-5">
                                    <h3 class="font-weight-bolder text-dark font-size-h4 font-size-h1-lg"><%= Language.GetFixed("SifremiUnuttum") %></h3>
                                    <p class="text-muted font-weight-bold font-size-h4"><%= Language.GetFixed("SifremiUnuttumAciklama") %></p>
                                </div>
                                <div class="form-group">
                                    <input class="form-control form-control-solid h-auto py-7 px-6 rounded-lg font-size-h6" type="email" placeholder="Email" name="email" autocomplete="off" />
                                </div>
                                <div class="form-group d-flex flex-wrap pb-lg-0">
                                    <a href="javascript:;" onclick="ForgotPassword();" class="btn btn-primary font-weight-bolder font-size-h6 px-8 py-4 my-3 mr-4"><%= Language.GetFixed("Gonder") %></a>
                                    <a href="javascript:;" id="kt_login_forgot_cancel" class="btn btn-light-primary font-weight-bolder font-size-h6 px-8 py-4 my-3"><%= Language.GetFixed("Iptal") %></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <script>var KTAppSettings = { "breakpoints": { "sm": 576, "md": 768, "lg": 992, "xl": 1200, "xxl": 1200 }, "colors": { "theme": { "base": { "white": "#ffffff", "primary": "#02081e", "secondary": "#E5EAEE", "success": "#02081e", "info": "#6993FF", "warning": "#FFA800", "danger": "#F64E60", "light": "#F3F6F9", "dark": "#212121" }, "light": { "white": "#ffffff", "primary": "#02081e", "secondary": "#ECF0F3", "success": "#C9F7F5", "info": "#E1E9FF", "warning": "#FFF4DE", "danger": "#FFE2E5", "light": "#F3F6F9", "dark": "#D6D6E0" }, "inverse": { "white": "#ffffff", "primary": "#ffffff", "secondary": "#212121", "success": "#ffffff", "info": "#ffffff", "warning": "#ffffff", "danger": "#ffffff", "light": "#464E5F", "dark": "#ffffff" } }, "gray": { "gray-100": "#F3F6F9", "gray-200": "#ECF0F3", "gray-300": "#E5EAEE", "gray-400": "#D6D6E0", "gray-500": "#B5B5C3", "gray-600": "#80808F", "gray-700": "#464E5F", "gray-800": "#1B283F", "gray-900": "#212121" } }, "font-family": "Poppins" };</script>
        <script src="/raven/assets/js/plugins.bundle.js?v=<%= Feature.Version %>"></script>
        <script src="/raven/assets/js/prismjs.bundle.js?v=<%= Feature.Version %>"></script>
        <script src="/raven/assets/js/scripts.bundle.js?v=<%= Feature.Version %>"></script>
        <script src="/raven/assets/js/fullcalendar.bundle.js?v=<%= Feature.Version %>"></script>
		<script src="/raven/assets/js/page.login.js?v=<%= Feature.Version %>"></script>
        <script src="/raven/assets/vendors/app.global.js?v=<%= Feature.Version %>"></script>
        <script src="/raven/assets/vendors/app.login.js?v=<%= Feature.Version %>"></script>

    </form>
</body>
</html>