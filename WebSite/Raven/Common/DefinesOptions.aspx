<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="DefinesOptions.aspx.cs" Inherits="WebSite.Raven.Common.DefinesOptions" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="25" />
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
                                    <a href="?dhx=add&catid=<%= Request["catid"] %>&define=<%= Request["define"] %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
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
                                        <th><%= Language.GetFixed("Baslik") %></th>
                                        <% if (forUser) { %>
                                        <th style="width: 100px;"><%= Language.GetFixed("Dosya") %></th>
                                        <% } else { %>
                                        <th style="width: 50px;">Only Sales Executive</th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 100px;"><%= Language.GetFixed("Islem") %></th>
                                        <% } %>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.zDefineDetails> dList = Bll.zDefineDetails.Select(0, filter: whereClause,  sorting: " Sorting ASC, id DESC");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id %></td>
                                            <td><%= item.Title  %></td>
                                            <% if (forUser) { %>
                                            <td><%= item.FileTypeID == 7 ? Developer.ShowLink(item.Description) : Developer.ShowReportFile(item.Filename)  %></td>
                                             <% } else { %>
                                            <td>
                                                <div class="checkbox-list">
                                                    <label class="checkbox">
                                                        <input id="ckSales<%= item.id %>" name="forSales" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.forSales) ? "checked" : "" %> />
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </td>
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
                                                <a href="?dhx=edit&id=<%= item.id + "&catid=" + item.CatID %>&define=<%= item.DefineID %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Duzenle") %>">
                                                    <i class="la la-edit"></i></a>
                                                <% if (Convert.ToBoolean(item._hasSubOptions)){ %>
                                                <a href="<%= Developer.ConstantUrl("doptions") %>?catid=<%= item.CatID %>&define=<%= item.id %>" class="btn btn-sm btn-clean btn-icon mr-2" title="Seçenekler"><i class="la la-list"></i></a>
                                                <% } %>
                                                <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Sil") %>"><i class="la la-trash"></i></a>
                                            </td>
                                            <% } %>
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
                            <input id="DefineID" class="form-control form-data" type="hidden" value="<%= DefineID %>" />
                            <% List<Entities.zDefineDetails> dList = Bll.zDefineDetails.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Baslik") %> *</label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Title : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Aciklama") %></label>
                                <textarea id="Description" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Description : "" %></textarea>
                            </div>
                            <!--<div class="form-group">
                                <label><%= Language.GetFixed("Fiyat") %></label>
                                <input id="Amount" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Amount : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Icon") %></label>
                                <input id="Icon" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Icon : "" %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Renk") %></label>
                                <input id="Color" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Color : "" %>" />
                            </div>-->
                            <div class="form-group">
                                <label><%= Language.GetFixed("DosyaTuru") %></label>
                                <select id="FileTypeID" class="form-control form-data form-data-option">
                                    <option value="0" <%= RecordID > 0 ? (dList[0].FileTypeID.ToString() == "0" ? "selected" : "") : "" %>>Pdf </option>
                                    <option value="1" <%= RecordID > 0 ? (dList[0].FileTypeID.ToString() == "1" ? "selected" : "") : "" %>>Word </option>
                                    <option value="2" <%= RecordID > 0 ? (dList[0].FileTypeID.ToString() == "2" ? "selected" : "") : "" %>>Excel </option>
                                    <option value="3" <%= RecordID > 0 ? (dList[0].FileTypeID.ToString() == "3" ? "selected" : "") : "" %>>PowerPoint </option>
                                    <option value="4" <%= RecordID > 0 ? (dList[0].FileTypeID.ToString() == "4" ? "selected" : "") : "" %>>Rar File</option>
                                    <option value="5" <%= RecordID > 0 ? (dList[0].FileTypeID.ToString() == "5" ? "selected" : "") : "" %>>Image</option>
                                    <option value="6" <%= RecordID > 0 ? (dList[0].FileTypeID.ToString() == "6" ? "selected" : "") : "" %>>Video</option>
                                    <option value="7" <%= RecordID > 0 ? (dList[0].FileTypeID.ToString() == "7" ? "selected" : "") : "" %>>Outer Link</option>
                                </select>
                            </div>
                            <% if (dList.Count > 0 && !String.IsNullOrEmpty(dList[0].Filename)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= dList.Count > 0 ? Developer.ShowReportFile(dList[0].Filename) : "" %></td>
                                        <td><%= dList.Count > 0 ? Developer.DeleteFileButton("reports", "Filename", dList[0].Filename) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Dosya") %></label>
                                <div class="custom-file">
                                    <input id="Filename" class="custom-file-input form-data" type="file" data-crop="false" data-path="reports" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
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