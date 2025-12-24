<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Records.aspx.cs" Inherits="WebSite.Raven.Translate.Records" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="13" />
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
                                    <a href="?dhx=add&catid=<%= Request["catid"] %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;Yeni Kayıt</a>
                                    <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i>&nbsp;Liste Verilerini Güncelle</a>
                                    <% } else { %>
                                    <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;Kaydet</a>
                                    <% } %>
                                    <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;Geri Dön</a>
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
                                        <th style="width: 150px;">Geçerli Dil</th>
                                        <th>Başlık</th>
                                        <th style="width: 150px;">Tarih</th>
                                        <th style="width: 150px;">İşlem</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.LangRecords> dList = Bll.LangRecords.Select(0, filter: whereClause);
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td>
                                                <a href="<%= Select.GlobalSiteDetailLink(Convert.ToInt32(item.CatID), item.id) %>" target="_blank">
                                                        <i class="la la-external-link"></i>&nbsp;<%= item.id %>
                                                </a>
                                            </td>
                                            <td><%= item._Language  %></td>
                                            <td><%= item.Title  %></td>
                                            <td><%= !String.IsNullOrEmpty(item.UpdatedDate.ToString()) ? Helper.DateFormat(item.UpdatedDate.ToString()) : Helper.DateFormat(item.CreatedDate.ToString()) %></td>
                                            <td>
                                                <a href="?dhx=edit&id=<%= item.id + "&catid=" + item.CatID  + "&ptype=" + item._PageTypeID %>" class="btn btn-sm btn-clean btn-icon" data-toggle='tooltip' data-theme='dark' title="Düzenle">
                                                    <i class="la la-edit"></i></a>
                                                <a href="<%= Developer.ConstantUrl("features") + "?catid=" + item.CatID + "&ptype=" + item._PageTypeID + "&lang=" + item.LangID%>" class="btn btn-sm btn-clean btn-icon" data-toggle='tooltip' data-theme='dark' title="Özellik Ekle">
                                                    <i class="la la-list"></i></a>
                                                <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon" data-toggle='tooltip' data-theme='dark' title="Sil">
                                                    <i class="la la-trash"></i></a>
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
                            <input id="CatID" class="form-control form-data" type="hidden" value="<%= CatID %>" />
                            <% List<Entities.LangRecords> dList = Bll.LangRecords.Select(RecordID, filter: ""); %>
                            
                            <div class="form-group">
                                <label>Geçerli Dil</label>
                                <select id="LangID" class="form-control form-data form-data-option">
                                    <option value="0">Lütfen dili seçiniz</option>
                                    <% List<Entities.zLangCodes> dataList = Bll.zLangCodes.Select(0, filter: " AND id<>" + Entities.StaticList.Settings.DefaultLanguage +" AND Approved=1");
                                        foreach (var items in dataList) { %>
                                        <option value="<%= items.id %>" <%= RecordID > 0 && dList[0].LangID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Başlık</label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Title : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>H1 Title</label>
                                <input id="AdditionalTitle" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].AdditionalTitle : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label>Meta Title</label>
                                <input id="MetaTitle" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].MetaTitle : "" %>" required/>
                            </div>
                            <div class="form-group">
                                <label>Meta Url</label>
                                <input id="MetaUrl" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].MetaUrl : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label>Meta Keywords</label>
                                <input id="Keywords" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Keywords : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label>Meta Description</label>
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
                                <label>Payment Plan</label>
                                <textarea id="PropertyPaymentPlan" class="form-control form-data summernote"><%= RecordID > 0 ? dList[0].PropertyPaymentPlan : "" %></textarea>
                            </div>
                        </div>
                    </div>
                    <% } %>

                    
                    <div class="card card-custom gutter-b example example-compact">
                        <div class="card-header border-0 pt-5">
							<h3 class="card-title align-items-start flex-column">
                                <span class="card-label font-weight-bolder text-dark"><%= Language.GetFixed("KayitIceriği") %></span>
                                <span class="text-muted mt-3 font-weight-bold font-size-sm"><%= Language.GetFixed("KayitIceriğiAciklama") %></span>
							</h3>
						</div>
                        <div class="card-body pt-0">
                            <div class="form-group">
                                <label>Kısa İçerik</label>
                                <textarea id="ShortContent" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ShortContent : "" %></textarea>
                            </div>
                            <div class="form-group">
                                <label>İçerik</label>
                                <div class="col-md-12">
                                    <textarea id="MainContent" class="form-control form-data summernote"><%= RecordID > 0 ? dList[0].MainContent : "" %></textarea>
                                </div>
                            </div>
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
                            <div class="form-group row">
                                <label>Resim</label>
                                <div class="custom-file">
                                    <input id="Image" class="custom-file-input form-data" type="file" data-crop="true" data-path="images" />
                                    <label class="custom-file-label" for="customFile">".jpg" , ".gif" , ".png" , ".svg" formatlarında resimleri buradan seçebilirsiniz. </label>
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
                            <div class="form-group row">
                                <label>Küçük Resim</label>
                                <div class="custom-file">
                                    <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile">".jpg" , ".gif" , ".png" , ".svg" formatlarında resimleri buradan seçebilirsiniz. </label>
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
                            <div class="form-group row">
                                <label>Dosya</label>
                                <div class="custom-file">
                                    <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile">".jpg" , ".gif" , ".png" , ".svg" formatlarında resimleri buradan seçebilirsiniz. </label>
                                </div>
                            </div>
                            <% } %>
                            -->
                        </div>
                        <div class="card-footer">
                            <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;Değişikleri Kaydet&nbsp;</a>
                            <a href="javascript:;" class="btn btn-secondary font-weight-bold" onclick="window.history.back()">Geri Dön</a>
                        </div>
                    </div>

                    <% } %>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>