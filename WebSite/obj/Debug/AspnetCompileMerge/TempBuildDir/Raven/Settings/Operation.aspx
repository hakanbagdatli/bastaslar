<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Operation.aspx.cs" Inherits="WebSite.Raven.Settings.Operation" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="Server">
    
    <input id="table" class="form-control" type="hidden" value="20" />
    <input id="id" class="form-control form-data" type="hidden" value="1" />
    <% List<Entities.zSettings> dList = Bll.zSettings.Select(1, filter: ""); %>

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
                            <div class="form-group">
                                <label><%= Language.GetFixed("FirmaAdi") %></label>
                                <input id="CompanyName" class="form-control form-data" type="text" value="<%= dList[0].CompanyName %>" />
                            </div>
                            <!--<div class="form-group">
                                <label><%= Language.GetFixed("Telefon") %></label>
                                <input id="Phone" class="form-control form-data" type="text" value="<%= dList[0].Phone %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("TanitimVideo") %></label>
                                <input id="Trailer" class="form-control form-data" type="text" value="<%= dList[0].Trailer %>" />
                            </div>-->
                            <div class="form-group">
                                <label><%= Language.GetFixed("Email") %></label>
                                <input id="Email" class="form-control form-data" type="text" value="<%= dList[0].Email %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("EmailGonderen") %></label>
                                <input id="EmailSenderName" class="form-control form-data" type="text" value="<%= dList[0].EmailSenderName %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("EmailImza") %></label>
                                <textarea id="EmailSign" class="form-control form-data" rows="4"><%= dList[0].EmailSign %></textarea>
                            </div>
                            <hr />
                            <div class="form-group">
                                <label>Book Now Link</label>
                                <input id="BookNowLink" class="form-control form-data" type="text" value="<%= dList[0].BookNowLink %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("FacebookAdres") %></label>
                                <input id="FacebookAddress" class="form-control form-data" type="text" value="<%= dList[0].FacebookAddress %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("InstagramAdres") %></label>
                                <input id="InstagramAddress" class="form-control form-data" type="text" value="<%= dList[0].InstagramAddress %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("YoutubeAdres") %></label>
                                <input id="YouTubeAddress" class="form-control form-data" type="text" value="<%= dList[0].YouTubeAddress %>" />
                            </div>
                            <!--
                            <div class="form-group">
                                <label><%= Language.GetFixed("Whatsapp") %></label>
                                <input id="Whatsapp" class="form-control form-data" type="text" value="<%= dList[0].Whatsapp %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("SkypeAdres") %></label>
                                <input id="SkypeAddress" class="form-control form-data" type="text" value="<%= dList[0].SkypeAddress %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("TiktokAdres") %></label>
                                <input id="TiktokAddress" class="form-control form-data" type="text" value="<%= dList[0].TiktokAddress %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("LinkedinAdres") %></label>
                                <input id="LinkedinAddress" class="form-control form-data" type="text" value="<%= dList[0].LinkedinAddress %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("TwiterAdres") %></label>
                                <input id="TwiterAddress" class="form-control form-data" type="text" value="<%= dList[0].TwiterAddress %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("PinterestAdres") %></label>
                                <input id="PinterestAddress" class="form-control form-data" type="text" value="<%= dList[0].PinterestAddress %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("VimeoAdres") %></label>
                                <input id="VimeoAdrdess" class="form-control form-data" type="text" value="<%= dList[0].VimeoAdrdess %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("FriendfeedAdres") %></label>
                                <input id="FriendFeedAddress" class="form-control form-data" type="text" value="<%= dList[0].FriendFeedAddress %>" />
                            </div>-->
                            <hr />
                            <% if (!String.IsNullOrEmpty(dList[0].Favicon)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= Developer.ShowImage(dList[0].Favicon) %></td>
                                        <td><%= Developer.DeleteFileButton("images", "Favicon", dList[0].Favicon) %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("FirmaFavicon") %></label>
                                <div class="custom-file">
                                    <input id="Favicon" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <hr />
                            <% if (!String.IsNullOrEmpty(dList[0].SiteLogo)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= Developer.ShowImage(dList[0].SiteLogo) %></td>
                                        <td><%= Developer.DeleteFileButton("images", "SiteLogo", dList[0].SiteLogo) %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("SiteLogo") %></label>
                                <div class="custom-file">
                                    <input id="SiteLogo" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <% if (!String.IsNullOrEmpty(dList[0].FooterLogo)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= Developer.ShowImage(dList[0].FooterLogo) %></td>
                                        <td><%= Developer.DeleteFileButton("images", "FooterLogo", dList[0].FooterLogo) %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("FooterLogo") %></label>
                                <div class="custom-file">
                                    <input id="FooterLogo" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <!--
                            <hr />
                            <% if (!String.IsNullOrEmpty(dList[0].DarkLogo)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;background:#000000;"><%= Developer.ShowImage(dList[0].DarkLogo) %></td>
                                        <td><%= Developer.DeleteFileButton("images", "DarkLogo", dList[0].DarkLogo) %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("SiteLogoSiyah") %></label>
                                <div class="custom-file">
                                    <input id="DarkLogo" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <hr />
                            <hr />
                            <div class="form-group<%= String.IsNullOrEmpty(dList[0].MobileLogo) ? " d-none" : "" %>">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= Developer.ShowImage(dList[0].MobileLogo) %></td>
                                        <td><%= Developer.DeleteFileButton("images", "MobileLogo", dList[0].MobileLogo) %></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("MobilLogo") %></label>
                                <div class="custom-file">
                                    <input id="MobileLogo" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <hr />
                            <div class="form-group<%= String.IsNullOrEmpty(dList[0].Promotion) ? " d-none" : "" %>">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= Developer.ShowImage(dList[0].Promotion) %></td>
                                        <td><%= Developer.DeleteFileButton("videos", "Promotion", dList[0].Promotion) %></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("TanitimVideo") %></label>
                                <div class="custom-file">
                                    <input id="Promotion" class="custom-file-input form-data" type="file" data-crop="false" data-path="videos" />
                                    <label class="custom-file-label" for="customFile">Videoyu buradan seçebilirsiniz.</label>
                                </div>
                            </div>
                            <hr />
                            <div class="form-group">
                                <div class="col-form-label">
                                    <div class="checkbox-list">
                                        <label class="checkbox">
                                            <input id="hasPopup" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].hasPopup) ? "checked" : "" %> />
                                            <span></span><%= Language.GetFixed("AcilisResimDurum") %>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group<%= String.IsNullOrEmpty(dList[0].PopupImage) ? " d-none" : "" %>">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= Developer.ShowImage(dList[0].PopupImage) %></td>
                                        <td><%= Developer.DeleteFileButton("images", "PopupImage", dList[0].PopupImage) %></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("AcilisResim") %></label>
                                <div class="custom-file">
                                    <input id="PopupImage" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("AcilisResimURL") %></label>
                                <input id="PopupUrl" class="form-control form-data" type="text" value="<%= dList[0].PopupUrl %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("AcilisResimTur") %></label>
                                <select id="PopupUrlTarget" class="form-control form-data form-data-option" data-value="<%= dList[0].PopupUrlTarget %>">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <option value="_self"><%= Language.GetFixed("AyniSayfa") %></option>
                                    <option value="_blank"><%= Language.GetFixed("AyriSayfa") %></option>
                                </select>
                            </div>-->

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
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server"></asp:Content>