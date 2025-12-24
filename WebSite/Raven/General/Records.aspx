<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Records.aspx.cs" Inherits="WebSite.Raven.General.Records" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="9" />
    <div class="d-flex flex-column-fluid">
        <div class="container">
            <div class="row">
                <div class="col-md-12">

                     <!-- header -->
                    <div class="card card-custom gutter-b example example-compact">
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
                                    <a href="?dhx=add&catid=<%= Request["catid"] %>&ptype=<%= Request["ptype"] %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
                                    <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i><%= Language.GetFixed("ListeGuncelle") %></a>
                                    <% } else { %>
                                    <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                                    <% } %>
                                    <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <% if (Request["dhx"] == null) { %>

                    <!-- body -->
                    <div class="card card-custom gutter-b example example-compact">
                        <div class="card-body">
                            <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">ID</th>
                                        <th style="width: 150px;"><%= Language.GetFixed("Kategori") %></th>
                                        <th><%= Language.GetFixed("Baslik") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 150px;"><%= Language.GetFixed("Tarih") %></th>
                                        <th style="width: 200px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.GeneralRecords> dList = Bll.GeneralRecords.Select(0, filter: whereClause, sorting: " Sorting ASC, id DESC");
                                        foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td>
                                            <a href="<%= Handler.SetMetaURL(item.CatID, item.id, true) %>" target="_blank">
                                                <i class="la la-external-link"></i>&nbsp;<%= item.id %>
                                            </a>
                                        </td>
                                        <td><a href="<%= Developer.ConstantUrl("content") + "?catid=" + item.CatID + "&ptype=" + item._PageTypeID %>" data-toggle='tooltip' data-theme='dark' title="<%= Select.MultipleCategoryName(Convert.ToInt32(item.CatID)) %>"><%= item._CategoryName %></a></td>
                                        <td><%= item.Title  %></td>
                                        <td>
                                            <input id="txtSort<%= item.id %>" name="Sorting" type="text" class="form-control list-form-data center" autocomplete="off" value="<%= item.Sorting %>" />
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckApp<%= item.id %>" name="Approved" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Approved) ? "checked" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckDel<%= item.id %>" name="isDeleted" type="checkbox" class="list-form-data" />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td><%= !String.IsNullOrEmpty(item.UpdatedDate.ToString()) ? Helper.DateFormat(item.UpdatedDate.ToString()) : Helper.DateFormat(item.CreatedDate.ToString()) %></td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="?dhx=edit&id=<%= item.id + "&catid=" + item.CatID  + "&ptype=" + item._PageTypeID %>" class="btn btn-outline-secondary font-weight-bold"><%= Language.GetFixed("Duzenle") %></a>
                                                <% if (PageTypeID == 15) { %>
                                                <a href="<%= Developer.ConstantUrl("plans") + "?catid=" + item.id + "&ptype=" + item._PageTypeID %>" class="btn btn-outline-secondary font-weight-bold"><%= Language.GetFixed("Properties") %></a>
                                                <% } %>
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-secondary font-weight-bold dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <%= Language.GetFixed("Islem") %>
                                                    </button>
                                                    <div class="dropdown-menu">
                                                        <a href="<%= Developer.ConstantUrl("con-languages") + "?catid=" + item.id + "&ptype=" + item._PageTypeID %>" class="dropdown-item">
                                                            <i class="la la-language mr-1"></i><%= Language.GetFixed("DilYonetimi") %></a>
                                                        <a href="<%= Developer.ConstantUrl("gallery") + "?catid=" + item.id + "&ptype=" + item._PageTypeID  %>" class="dropdown-item">
                                                            <i class="la la-image mr-1"></i><%= Language.GetFixed("ResimEkle") %></a>
                                                        <a href="<%= Developer.ConstantUrl("files") + "?catid=" + item.id + "&ptype=" + item._PageTypeID  %>" class="dropdown-item">
                                                            <i class="la la-file-pdf mr-1"></i><%= Language.GetFixed("DosyaEkle") %></a>
                                                        <a href="<%= Developer.ConstantUrl("videos") + "?catid=" + item.id + "&ptype=" + item._PageTypeID %>" class="dropdown-item">
                                                            <i class="la la-video mr-1"></i><%= Language.GetFixed("VideoEkle") %></a>
                                                        <a href="<%= Developer.ConstantUrl("features") + "?catid=" + item.id + "&ptype=" + item._PageTypeID %>" class="dropdown-item">
                                                            <i class="la la-list mr-1"></i><%= Language.GetFixed("OzellikEkle") %></a>
                                                        <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="dropdown-item">
                                                            <i class="la la-trash mr-1"></i><%= Language.GetFixed("Sil") %></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <% } else { %>

                    <!-- seo -->
                    <div class="card card-custom gutter-b example example-compact">
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label font-weight-bolder text-dark"><%= Language.GetFixed("SeoYoneticisi") %></span>
                                <span class="text-muted mt-3 font-weight-bold font-size-sm"><%= Language.GetFixed("SeoYoneticisiAciklama") %></span>
                            </h3>
                        </div>
                        <div class="card-body">
                            <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                            <% List<Entities.GeneralRecords> dList = Bll.GeneralRecords.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("UstKategoriAdi") %> *</label>
                                <select id="CatID" class="form-control form-data form-data-option" required>
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <%  string categoryClause = ((PageTypeID == 15 || PageTypeID == 16) ? " AND id<>3 AND id in (" + Select.MultipleCategoryID(3) + ") AND Approved=1" : " AND Approved=1");
                                        List<Entities.GeneralCategories> dataList = Bll.GeneralCategories.Select(0, filter: categoryClause);
                                        foreach (var items in dataList) { %>
                                    <option value="<%= items.id %>" <%= CatID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <!--<div class="form-group">
                                <div class="checkbox-inline">
                                    <label class="checkbox">
                                        <input id="isTopMenu" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].isTopMenu) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("UstMenuDurum") %>
                                    </label>
                                    <label class="checkbox">
                                        <input id="DontAppearSiteMap" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].DontAppearSiteMap) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("NoIndex") %>
                                    </label>
                                    <label class="checkbox">
                                        <input id="onMainPage" type="checkbox" class="form-data" <%= RecordID > 0 && Convert.ToBoolean(dList[0].onMainPage) ? "checked" : "" %> />
                                        <span></span><%= Language.GetFixed("AnasayfaDurum") %>
                                    </label>
                                </div>
                            </div>-->
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
                                <input id="MetaTitle" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].MetaTitle : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("MetaUrl") %> *</label>
                                <input id="MetaUrl" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].MetaUrl : "" %>" required />
                            </div>
                            <!--<div class="form-group">
                                <label><%= Language.GetFixed("MetaKeywords") %></label>
                                <input id="Keywords" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Keywords : "" %>" required />
                            </div>-->
                            <div class="form-group">
                                <label><%= Language.GetFixed("MetaDescription") %></label>
                                <textarea id="Description" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Description : "" %></textarea>
                            </div>
                        </div>
                    </div>
                    
                    <% if (PageTypeID == 15 || PageTypeID == 16 || PageTypeID == 18) { %>
                    <!-- properties -->
                    <div class="card card-custom gutter-b example example-compact">
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label font-weight-bolder text-dark"><%= Language.GetFixed("ProjeYoneticisi") %></span>
                                <span class="text-muted mt-3 font-weight-bold font-size-sm"><%= Language.GetFixed("ProjeYoneticisiAciklama") %></span>
                            </h3>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label><%= Language.GetFixed("ProjeDurum") %></label>
                                <select id="PropertyStatu" class="form-control form-data form-data-option">
                                    <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 2))) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].PropertyStatu == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("VillaSayisi") %></label>
                                <input id="PropertyVillaCount" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyVillaCount : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("DaireSayisi") %></label>
                                <input id="PropertyFlatCount" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyFlatCount : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>m² (Net)</label>
                                <input id="PropertySize" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertySize : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("BaslangicTarih") %></label>
                                <input id="PropertyStartDate" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyStartDate : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("BitisTarih") %></label>
                                <input id="PropertyEndDate" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyEndDate : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("SosyalMedya") %></label>
                                <input id="PropertySocialMedia" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertySocialMedia : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("SanalTurLinki") %></label>
                                <textarea id="PropertyVirtualTour" class="form-control form-data" rows="5"><%= RecordID > 0 ? dList[0].PropertyVirtualTour : "https://3d.sunvalleycyprus.com/" %></textarea>
                            </div>
                            <div class="form-group">
                                <label>Google Map Embed</label>
                                <textarea id="PropertyLocation" class="form-control form-data" rows="5"><%= RecordID > 0 ? dList[0].PropertyLocation : "" %></textarea>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("OdemePlani") %></label>
                                <textarea id="PropertyPaymentPlan" class="form-control form-data summernote"><%= RecordID > 0 ? dList[0].PropertyPaymentPlan : "" %></textarea>
                            </div>
                            <!--
                            <div class="form-group">
                                <label><%= Language.GetFixed("KonutTipleri") %></label>
                                <input id="PropertyFlatTypes" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyFlatTypes : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("EmlakTipi") %></label>
                                <select id="PropertyType" class="form-control form-data form-data-option">
                                    <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 3))) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].PropertyType == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Sehir") %></label>
                                <select id="PropertyProvince" class="form-control form-data form-data-option">
                                    <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 5))) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].PropertyProvince == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Country") %></label>
                                <select id="PropertyCountry" class="form-control form-data form-data-option">
                                    <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 4))) { %>
                                        <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].PropertyCountry == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Google Drive Link</label>
                                <input id="PropertyAddress" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyAddress : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("ProjeImkanlari") %></label>
                                <textarea id="PropertyFeatures" class="form-control form-data summernote"><%= RecordID > 0 ? dList[0].PropertyFeatures : "" %></textarea>
                            </div>
                            <div class="form-group">
                                <label>Fiyat Aralığı</label>
                                <input id="<%= Language.GetFixed("FiyatAraligi") %>" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].PropertyPrice : "" %>" />
                            </div>-->
                        </div>
                    </div>
                    <% } %>

                    <!-- records -->
                    <div class="card card-custom gutter-b example example-compact">
                        <div class="card-header border-0 pt-5">
                            <h3 class="card-title align-items-start flex-column">
                                <span class="card-label font-weight-bolder text-dark"><%= Language.GetFixed("KayitIceriği") %></span>
                                <span class="text-muted mt-3 font-weight-bold font-size-sm"><%= Language.GetFixed("KayitIceriğiAciklama") %></span>
                            </h3>
                        </div>
                        <div class="card-body pt-0">
                            <% if (PageTypeID == 12) { %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("HaberTarihi") %></label>
                                <input id="RecordDate" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].RecordDate : "" %>" />
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("KisaIcerik") %></label>
                                <textarea id="ShortContent" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ShortContent : "" %></textarea>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Icerik") %></label>
                                <div class="col-md-12">
                                    <textarea id="MainContent" class="form-control form-data summernote"><%= RecordID > 0 ? dList[0].MainContent : "" %></textarea>
                                </div>
                            </div>
                            <% if (PageTypeID == 12) { %>
                            <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].Thumbnail)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowImage(dList[0].Thumbnail) : "" %></td>
                                        <td><%= RecordID > 0 ? Developer.DeleteFileButton("images", "Thumbnail", dList[0].Thumbnail) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("KucukResim") %></label>
                                <div class="custom-file">
                                    <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
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
                            <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].Filename)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowImage(dList[0].Filename) : "" %></td>
                                        <td><%= RecordID > 0 ? Developer.DeleteFileButton("files", "Filename", dList[0].Filename) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Dosya") %></label>
                                <div class="custom-file">
                                    <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            -->
                        </div>
                        <div class="card-footer">
                            <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                            <a href="javascript:;" class="btn btn-secondary font-weight-bold" onclick="window.history.back()">&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                        </div>

                    </div>

                    <% } %>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>