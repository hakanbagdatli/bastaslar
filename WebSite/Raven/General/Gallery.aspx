<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="WebSite.Raven.General.Gallery" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Entities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="8" />
    <div class="d-flex flex-column-fluid">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-custom gutter-b example example-compact">

                        <% if (Convert.ToBoolean(StaticList.Settings.canAddMultipleFile)) { %>
                        <div class="form-group pt-3">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <div class="dropzone dropzone-default dropzone-warning" id="dZUpload">
								    <div class="dropzone-msg dz-message needsclick">
									    <h3 class="dropzone-msg-title"><%= Language.GetFixed("TopluResimYuklemeBaslik") %></h3>
									    <span class="dropzone-msg-desc"><%= Language.GetFixed("TopluResimYuklemeAciklama") %></span>
								    </div>
							    </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <% } %>

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
                                        <% if (Convert.ToBoolean(StaticList.Settings.canAddMultipleFile)) { %>
                                            <a id="btnUploadImage" class="btn btn-primary font-weight-bold"><i class="la la-cloud-upload"></i>&nbsp;<%= Language.GetFixed("ResimleriYukle") %></a>
                                        <%} else { %>
                                            <a href="?dhx=add&catid=<%= Request["catid"] %>&ptype=<%= Request["ptype"] %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
                                        <% } %>
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
                            <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">ID</th>
                                        <th style="width: 75px;"><%= Language.GetFixed("Resim") %></th>
                                        <th><%= Language.GetFixed("DilKodu") %></th>
                                        <th><%= Language.GetFixed("Baslik") %></th>
                                        <% if (PageTypeID == 16 || PageTypeID == 18) { %>
                                        <th><%= Language.GetFixed("Properties") %></th>
                                        <th>Social Media</th>
                                        <th>Outdoor</th>
                                        <th>Indoor</th>
                                        <% } %>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 100px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.GeneralPhotos> dList = Bll.GeneralPhotos.Select(0, filter: whereClause,  sorting: " Sorting ASC, id ASC");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id %></td>
                                            <td><%= Developer.ShowImage(item.Image) %></td>
                                            <td><%= item.LangID == 0 ? "Universal" : item._Language %></td>
                                            <td><%= item.Title  %></td>
                                            <% if (PageTypeID == 16 || PageTypeID == 18) { %>
                                            <td><%= !String.IsNullOrEmpty(item._PropertyName) ? item._PropertyName : "Genel" %></td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckTyp<%= item.id %>" name="TypeID" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.TypeID) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckOut<%= item.id %>" name="Outdoor" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Outdoor) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckInd<%= item.id %>" name="Indoor" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Indoor) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
                                            <% } %>
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
                                            <td>
                                                <a href="?dhx=edit&id=<%= item.id + "&catid=" + item.CatID  + "&ptype=" + Request["ptype"].ToString() %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Duzenle") %>"><i class="la la-edit"></i></a>
                                                <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Sil") %>"><i class="la la-trash"></i></a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>

                        <% } else { %>

                        <!-- body -->
                        <div class="card-body">
                            <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                            <% List<Entities.GeneralPhotos> dList = Bll.GeneralPhotos.Select(RecordID, filter: ""); %>
                            <% if (PageTypeID == 16 || PageTypeID == 18) { %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("DilKodu") %></label>
                                <select id="LangID" class="form-control form-data form-data-option" data-value="<%= LangID %>">
                                    <option value="0">Universal</option>
                                    <% List<Entities.zLangCodes> dataPageList = Bll.zLangCodes.Select(0, filter: " AND Approved=1");
                                        foreach (var items in dataPageList) { %>
                                        <option value="<%= items.id %>" <%= RecordID > 0 && dList[0].LangID == items.id ? " selected" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Properties") %></label>
                                <select id="PropertyID" class="form-control form-data form-data-option" data-value="0">
                                    <option value="0">Genel</option>
                                    <% List<Entities.GeneralPlans> dataList = Bll.GeneralPlans.Select(0, filter: " AND CatID=" + CatID +" AND Approved=1");
                                        foreach (var items in dataList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].PropertyID == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Baslik") %></label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Title : "" %>" />
                            </div>
                            <!--<div class="form-group">
                                <label><%= Language.GetFixed("Link") %></label>
                                <input id="Link" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Link : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("KisaIcerik") %></label>
                                <textarea id="ShortContent" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].ShortContent : "" %></textarea>
                            </div>-->
                            <% if (dList.Count > 0 && !String.IsNullOrEmpty(dList[0].Image)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%=  dList.Count > 0 ? Developer.ShowImage(dList[0].Image) : "" %></td>
                                        <td><%=  dList.Count > 0 ? Developer.DeleteFileButton("images", "Image", dList[0].Image) : "" %></td>
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
                            <% if (dList.Count > 0 && !String.IsNullOrEmpty(dList[0].Thumbnail)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= dList.Count > 0 ? Developer.ShowImage(dList[0].Thumbnail) : "" %></td>
                                        <td><%= dList.Count > 0 ? Developer.DeleteFileButton("images", "Thumbnail", dList[0].Thumbnail) : "" %></td>
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
    <% if (Convert.ToBoolean(StaticList.Settings.canAddMultipleFile)) { %>
    <script type="text/javascript">
        Dropzone.autoDiscover = false;
        Dropzone.prototype.defaultOptions.dictCancelUpload = "İptal Et";
        Dropzone.prototype.defaultOptions.dictRemoveFile = "Resmi Sil";
        $(document).ready(function () {
            $("#dZUpload").dropzone({
                url: "/Raven/General/zUploader.ashx",
                addRemoveLinks: true,
                uploadMultiple: true,
                parallelUploads: 99,
                autoProcessQueue: false,
                success: function (file, response) {
                    file.previewElement.classList.add("dz-success");
                },
                error: function (file, response) {
                    file.previewElement.classList.add("dz-error");
                    alert(getLang(3), getLang(12), "error");
                },
                init: function () {
                    var myDropzone = this;
                    myDropzone.on("sending", function (file, xhr, formData) 
                    {
                        formData.append("Table", "images");
                        formData.append("CatID", "<%= CatID %>");
                    });
                    $('#btnUploadImage').on('click', function (e) {
                        e.preventDefault();
                        myDropzone.processQueue();
                    });
                    myDropzone.on("complete", function (file) {
                        if (this.getUploadingFiles().length === 0 && this.getQueuedFiles().length === 0) {
                            alertWithRedirect(getLang(1), getLang(13), "success", window.location.href);
                        }
                    });

                }
            });
        });
    </script>
    <% } %>
</asp:Content>