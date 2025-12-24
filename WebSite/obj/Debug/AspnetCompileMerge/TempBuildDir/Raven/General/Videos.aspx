<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Videos.aspx.cs" Inherits="WebSite.Raven.General.Videos" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="10" />
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
                                    <a href="?dhx=add&catid=<%= Request["catid"] %>&ptype=<%= Request["ptype"] %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
                                    <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i><%= Language.GetFixed("ListeGuncelle") %></a>
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
                                        <th style="width: 75px;"><%= Language.GetFixed("Video") %></th>
                                        <th><%= Language.GetFixed("DilKodu") %></th>
                                        <th><%= Language.GetFixed("Baslik") %></th>
                                        <% if (PageTypeID == 16 || PageTypeID == 18) { %>
                                        <th>Social Media</th>
                                        <% } %>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 100px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.GeneralVideos> dList = Bll.GeneralVideos.Select(0, filter: whereClause,  sorting: " Sorting ASC, id DESC");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id %></td>
                                            <td><%= Developer.ShowVideos(item.VideoEmbed, item.Image) %></td>
                                            <td><%= item.LangID == 0 ? "Universal" : item._Language %></td>
                                            <td><%= item.Title  %></td>
                                            <% if (PageTypeID == 16 || PageTypeID == 18) { %>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckTyp<%= item.id %>" name="TypeID" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.TypeID) ? "checked" : "" %> />
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
                            <input id="CatID" class="form-control form-data" type="hidden" value="<%= CatID %>" />
                            <% List<Entities.GeneralVideos> dList = Bll.GeneralVideos.Select(RecordID, filter: ""); %>
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
                                <label><%= Language.GetFixed("Baslik") %></label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Title : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Video") %></label>
                                <textarea id="VideoEmbed" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].VideoEmbed : "" %></textarea>
                            </div>
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
                            <% if (dList.Count > 0 && !String.IsNullOrEmpty(dList[0].VideoUrl)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= dList.Count > 0 ? Developer.ShowImage(dList[0].VideoUrl) : "" %></td>
                                        <td><%= dList.Count > 0 ? Developer.DeleteFileButton("files", "Filename", dList[0].VideoUrl) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Video") %></label>
                                <div class="custom-file">
                                    <input id="VideoUrl" class="custom-file-input form-data" type="file" data-crop="false" data-path="videos" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("KisaIcerik") %></label>
                                <textarea id="ShortContent" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].ShortContent : "" %></textarea>
                            </div>
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
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>