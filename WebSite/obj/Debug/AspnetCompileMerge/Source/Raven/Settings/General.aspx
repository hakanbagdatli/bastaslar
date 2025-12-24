<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="General.aspx.cs" Inherits="WebSite.Raven.Settings.General" %>
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
                                <label>E-Posta Hesabı</label>
                                <input id="EmailUsername" class="form-control form-data" type="text" value="<%= dList[0].EmailUsername %>" />
                            </div>
                            <div class="form-group">
                                <label>E-Posta Şifre</label>
                                <input id="EmailPassword" class="form-control form-data" type="text" value="<%= dList[0].EmailPassword %>" />
                            </div>
                            <div class="form-group">
                                <label>E-Posta Host</label>
                                <input id="EmailSmtpHost" class="form-control form-data" type="text" value="<%= dList[0].EmailSmtpHost %>" />
                            </div>
                            <div class="form-group">
                                <label>E-Posta Port</label>
                                <input id="EmailSmtpPort" class="form-control form-data" type="text" value="<%= dList[0].EmailSmtpPort %>" />
                            </div>
                            <hr />
                            <div class="form-group">
                                <label>Sayfalama</label>
                                <input id="NumberofListings" class="form-control form-data" type="text" value="<%= dList[0].NumberofListings %>" />
                            </div>
                            <div class="form-group">
                                <label>Url Link Tür</label>
                                <select id="UrlLinkType" class="form-control form-data form-data-option" data-value="<%= dList[0].UrlLinkType %>">
                                    <option value="0">En Üst Kategori URL</option>
                                    <option value="1">Üst Kategori URL</option>
                                    <option value="3">Sadece Kategori URL</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Site Dili</label>
                                <div>
                                    <select id="DefaultLanguage" class="form-control form-data form-data-option" data-value="<%= dList[0].DefaultLanguage %>">
                                        <option value="tr">Türkçe</option>
                                        <option value="en">İngilizce</option>
                                        <option value="ar">Arapça</option>
                                        <option value="de">Almanca</option>
                                        <option value="fr">Fransızca</option>
                                        <option value="ru">Rusça</option>
                                        <option value="ja">Japonca</option>
                                        <option value="zh">Çince</option>
                                        <option value="it">Italyanca</option>
                                        <option value="pt">Portekizce</option>
                                        <option value="es">İspanyolca</option>
                                    </select>
                                </div>
                            </div>
                            <hr />
                            <div class="form-group">
                                <div class="checkbox-list">
                                    <label class="checkbox">
                                        <input id="isURLWithoutHTML" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].isURLWithoutHTML) ? "checked" : "" %> />
                                        <span></span>Url Html Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="isRssActive" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].isRssActive) ? "checked" : "" %> />
                                        <span></span>Rss Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="isSiteMapActive" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].isSiteMapActive) ? "checked" : "" %> />
                                        <span></span>Sitemap Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="canLoggin" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].canLoggin) ? "checked" : "" %> />
                                        <span></span>Log Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="canCrop" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].canCrop) ? "checked" : "" %> />
                                        <span></span>Crop Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="canRightClick" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].canRightClick) ? "checked" : "" %> />
                                        <span></span>Sağ Click Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="can301Redirect" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].can301Redirect) ? "checked" : "" %> />
                                        <span></span>301 Yönlendirme Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="canAddMultipleFile" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].canAddMultipleFile) ? "checked" : "" %> />
                                        <span></span>Çoklu Dosya Yükleme Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="canAddMultipleImage" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].canAddMultipleImage) ? "checked" : "" %> />
                                        <span></span>Çoklu Resim Yükleme Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="canDeleteMultiple" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].canDeleteMultiple) ? "checked" : "" %> />
                                        <span></span>Toplu Silme Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="canDeletePictures" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].canDeletePictures) ? "checked" : "" %> />
                                        <span></span>Resim Sil Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="canDeleteRelatedRecord" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].canDeleteRelatedRecord) ? "checked" : "" %> />
                                        <span></span>İlişkili Kayıtları Sil Durum
                                    </label>
                                    <label class="checkbox">
                                        <input id="isMultipleLangauge" type="checkbox" class="form-data" <%= Convert.ToBoolean(dList[0].isMultipleLangauge) ? "checked" : "" %> />
                                        <span></span>Çoklu Dil Durum
                                    </label>
                                </div>
                            </div>
                            <hr />

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