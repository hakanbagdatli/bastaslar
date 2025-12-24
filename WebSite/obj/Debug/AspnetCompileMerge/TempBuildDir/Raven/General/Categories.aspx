<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="WebSite.Raven.General.Categories" %>
<%@ Import Namespace="Tools" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        tr.mainmenu td:nth-child(2)::after,tr.submenu td:nth-child(2)::after{content:"";width:0;border-left:4px solid transparent;border-right:4px solid transparent;border-top:6px solid #23272c;height:0;position:absolute}tr.mainmenu td:nth-child(2)::after{right:50%;}tr.submenu td:nth-child(2)::after{left:250px;top:11px}tr.hidden{height:0;position:absolute;opacity:0;z-index:-1}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="4" />
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
                                    <% if (Request["dhx"] == null) { %>
                                    <a href="?dhx=add" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
                                    <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("ListeGuncelle") %></a>
                                    <% } else { %>
                                    <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                                    <% } %>
                                    <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                                </div>
                            </div>
                        </div>

                        <% if (Request["dhx"] == null) { %>

                        <!-- body -->
                        <div class="card-body">
                            <table class="panelList table table-separate table-head-custom table-checkable" id="liophinMenuTable">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">ID</th>
                                        <th><%= Language.GetFixed("KategoriAdi") %></th>
                                        <th style="width: 75px;"><%= Language.GetFixed("Sira") %></th>
                                        <th style="width: 75px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 75px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 200px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Literal ID="ltrlList" runat="server"></asp:Literal>
                                </tbody>
                            </table>
                        </div>

                        <% } else { %>

                        <!-- body -->
                        <div class="card-body">
                            <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                            <% List<Entities.GeneralCategories> dList = Bll.GeneralCategories.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("UstKategoriAdi") %> *</label>
                                <select id="CatID" class="form-control form-data form-data-option">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% List<Entities.GeneralCategories> dataList = Bll.GeneralCategories.Select(0, filter: " AND Approved=1");
                                        foreach (var items in dataList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 && dList[0].CatID == items.id ? " selected" : CatID > 0 && CatID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("SayfaTuru") %> *</label>
                                <select id="PageTypeID" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PageTypeID.ToString() : "0" %>" required>
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% foreach (var items in Entities.StaticList.PageTypes.Where(x => (x.Approved == 1))) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 && dList[0].PageTypeID == items.id ? " selected" : SubPageTypeID > 0 && SubPageTypeID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <div class="checkbox-inline">
                                    <label class="checkbox">
                                        <input id="isTopMenu" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].isTopMenu) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("UstMenuDurum") %>
                                    </label>
                                    <label class="checkbox">
                                        <input id="isBottomMenu" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].isBottomMenu) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("AltMenuDurum") %>
                                    </label>
                                    <label class="checkbox">
                                        <input id="isLeftMenu" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].isLeftMenu) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("SolMenuDurum") %>
                                    </label>
                                    <label class="checkbox">
                                        <input id="isMainPageMenu" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].isMainPageMenu) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("AnasayfaDurum") %>
                                    </label>
                                    <!--<label class="checkbox">
                                        <input id="isMegaMenu" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].isMegaMenu) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("MegaMenuDurum") %>
                                    </label>
                                    <label class="checkbox">
                                        <input id="DontAppearSiteMap" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].DontAppearSiteMap) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("NoIndex") %>
                                    </label>-->
                                </div>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Baslik") %> *</label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Title : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("H1Title") %></label>
                                <input id="AdditionalTitle" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].AdditionalTitle : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("MetaTitle") %></label>
                                <input id="MetaTitle" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].MetaTitle : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("MetaUrl") %> *</label>
                                <input id="MetaUrl" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].MetaUrl : "" %>" required />
                            </div>
                            <!--
                            <div class="form-group">
                                <label><%= Language.GetFixed("MetaKeywords") %></label>
                                <input id="Keywords" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Keywords : "" %>" />
                            </div>
                            -->
                            <div class="form-group">
                                <label><%= Language.GetFixed("MetaDescription") %></label>
                                <textarea id="Description" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Description : "" %></textarea>
                            </div>
                            <% if (RecordID > 0 && Convert.ToBoolean(dList[0].MenuLinkStatu) == true) { %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("AcilisSekli") %></label>
                                <select id="OpeningType" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].OpeningType : "0" %>">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <option value="_self"><%= Language.GetFixed("AyniSayfa") %></option>
                                    <option value="_blank"><%= Language.GetFixed("AyriSayfa") %></option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Link</label>
                                <input id="Link" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Link : "" %>" />
                            </div>
                            <% } %>

                            <% if (RecordID > 0 && Convert.ToBoolean(dList[0].ShortContentStatu) == true) { %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("KisaIcerik") %></label>
                                <textarea id="ShortContent" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ShortContent : "" %></textarea>
                            </div>
                            <% } %>

                            <% if (RecordID > 0 && Convert.ToBoolean(dList[0].ContentStatu) == true) { %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Icerik") %></label>
                                <div class="col-md-12">
                                    <textarea id="MainContent" class="form-control form-data summernote"><%= RecordID > 0 ? dList[0].MainContent : "" %></textarea>
                                </div>
                            </div>
                            <% } %>
                            <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].Image)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%=  RecordID > 0 ? Developer.ShowImage(dList[0].Image) : "" %></td>
                                        <td><%=  RecordID > 0 ? Developer.DeleteFileButton("images", "Image", dList[0].Image) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Resim") %></label>
                                <div class="custom-file">
                                    <input id="Image" class="custom-file-input form-data" type="file" data-crop="true" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <!--
                            <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].Thumbnail)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowImage(dList[0].Thumbnail) : "" %></td>
                                        <td><%= RecordID > 0 ? Developer.DeleteFileButton("images", "Thumbnail", dList[0].Thumbnail) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("KucukResim") %></label>
                                <div class="custom-file">
                                    <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <% } %>
                            <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].BannerImage)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowImage(dList[0].BannerImage) : "" %></td>
                                        <td><%= RecordID > 0 ? Developer.DeleteFileButton("images", "BannerImage", dList[0].BannerImage) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("BannerResim") %></label>
                                <div class="custom-file">
                                    <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <% } %>
                            <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].Filename)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowImage(dList[0].Filename) : "" %></td>
                                        <td><%= RecordID > 0 ? Developer.DeleteFileButton("files", "Filename", dList[0].Filename) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Dosya") %></label>
                                <div class="custom-file">
                                    <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <% } %>
                            -->
                        </div>

                        <!-- footer -->
                        <div class="card-footer">
                            <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                            <a href="javascript:;" class="btn btn-secondary font-weight-bold" onclick="window.history.back()">&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                        </div>

                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script>
        var table = $('#liophinMenuTable').DataTable({
            order: false,
            pageLength: 100
        });
        $(".panelList tr").click(function () {

            var ids = new Array(),
                cateid = $(this).data("id");

            $(".accordion" + cateid + "").each(function () {
                ids.push(cateid);
            });
            if ($(".accordion" + cateid + "").hasClass("hidden")) {
                $(".accordion" + cateid + "").removeClass("hidden");
            } else if ($(this).hasClass("color-red")) {
                if ($(this).hasClass("hidden")) {
                    $(".accordion" + cateid + "").removeClass("hidden")
                } else {
                    $(this).nextUntil(".ana-kategori").addClass("hidden");
                }
            } else {
                for (var i = 0; i < ids.length; i++) {
                    $(".accordion" + ids[i] + "").addClass("hidden");
                }
                $(".accordion" + cateid + "").addClass("hidden");
            }
        });
    </script>
</asp:Content>