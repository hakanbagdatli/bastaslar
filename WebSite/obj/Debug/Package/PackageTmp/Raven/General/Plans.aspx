<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Plans.aspx.cs" Inherits="WebSite.Raven.General.Plans" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Entities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="27" />
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
                                        <th><%= Language.GetFixed("ListeFiyati") %></th>
                                        <th>m² (Net)</th>
                                        <th><%= Language.GetFixed("YatakOdasi") %></th>
                                        <th><%= Language.GetFixed("Durum") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sira") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                        <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                        <th style="width: 100px;"><%= Language.GetFixed("Islem") %></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Entities.GeneralPlans> dList = Bll.GeneralPlans.Select(0, filter: whereClause,  sorting: " Sorting ASC, Title ASC");
                                        foreach (var item in dList) { %>
                                        <tr class="list-data" data-id="<%= item.id %>">
                                            <td><%= item.id %></td>
                                            <td><%= item.Title  %></td>
                                            <td><%= item.PropertyPrice  %> £</td>
                                            <td><%= item.PropertySize %></td>
                                            <td><%= item.PropertyBedroom  %></td>
                                            <td><%= Function.PropertyStatuBadge(item.PropertyStatus)  %></td>
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
                            <% List<Entities.GeneralPlans> dList = Bll.GeneralPlans.Select(RecordID, filter: ""); %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Baslik") %> *</label>
                                <input id="Title" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Title : "" %>" required />
                            </div>
                            <% if (PageTypeID == 15 || PageTypeID == 16 || PageTypeID == 18) { %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("DaireTipi") %> *</label>
                                <input id="PropertyUnitType" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyUnitType : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label>Floor *</label>
                                <input id="PropertyFloor" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyID : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("EmlakID") %> *</label>
                                <input id="PropertyID" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyID : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label><%=Language.GetFixed("Emlak3DID") %> *</label>
                                <input id="Property3ID" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Property3ID : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("EmlakFiyati") %> *</label>
                                <div class="input-group">
								    <div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                    <input id="PropertyPrice" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].PropertyPrice : "0" %>" required />
							    </div>
                                <small><%= Language.GetFixed("FiyatAciklama") %></small>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Durum") %> *</label>
                                <select id="PropertyStatus" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PropertyStatus : "available" %>" required>
                                    <option value="available">Available</option>
                                    <option value="reserved">Reserved</option>
                                    <option value="sold">Sold</option>
                                    <option value="unavailable">Unavailable</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Property Land Area (m²)</label>
                                <input id="PropertyLandArea" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyLandArea : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Property Garage Area (m²)</label>
                                <input id="PropertyGarageArea" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyGarageArea : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Property Pool Area (m²)</label>
                                <input id="PropertyPoolArea" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyPoolArea : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Closed Gross Area (m²)</label>
                                <input id="PropertyGrossArea" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyGrossArea : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Closed Terrace Area (m²)</label>
                                <input id="PropertyTerraceArea" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyTerraceArea : "" %>" />
                            </div>
                            <div class="form-group">
                                <label>Total Closed  Area (m²) *</label>
                                <input id="PropertySize" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertySize : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label>Open Terrace (m²)</label>
                                <input id="PropertyOpenTerrace" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyOpenTerrace : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label>Roof Terrace (m²)</label>
                                <input id="PropertyRoofTerrace" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyRoofTerrace : "" %>" required />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("YatakOdasi") %></label>
                                <input id="PropertyBedroom" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyBedroom : 1 %>" />
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Banyo") %></label>
                                <input id="PropertyBath" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].PropertyBath : 1 %>" />
                            </div>
                            <!--
                            <div class="form-group">
                                <label><%=Language.GetFixed("SanalTur") %></label>
                                <textarea id="PropertyVirtualTour" class="form-control form-data" rows="5"><%= RecordID > 0 ? dList[0].PropertyVirtualTour : "" %></textarea>
                            </div>
                            -->
                            <% } %>
                            <!--
                            <div class="form-group">
                                <label><%= Language.GetFixed("KisaIcerik") %></label>
                                <textarea id="ShortContent" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ShortContent : "" %></textarea>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Link") %></label>
                                <input id="Link" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Link : "" %>" />
                            </div>
                            -->
                            <div class="form-group">
                                <label><%= Language.GetFixed("Icerik") %></label>
                                <div class="col-md-12">
                                    <textarea id="MainContent" class="form-control form-data summernote" rows="4"><%= RecordID > 0 ? dList[0].MainContent : "" %></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label><%= Language.GetFixed("VideoEmbed") %></label>
                                <textarea id="VideoEmbed" class="form-control form-data" rows="4"><%= dList.Count > 0 ? dList[0].VideoEmbed : "" %></textarea>
                            </div>
                            <% if (dList.Count > 0 && !String.IsNullOrEmpty(dList[0].Filename)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= dList.Count > 0 ? Developer.ShowFile(dList[0].Filename) : "" %></td>
                                        <td><%= dList.Count > 0 ? Developer.DeleteFileButton("files", "Filename", dList[0].Filename) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Dosya") %> - English</label>
                                <div class="custom-file">
                                    <input id="Filename" class="custom-file-input form-data" type="file" data-crop="false" data-path="files" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                            <% if (dList.Count > 0 && !String.IsNullOrEmpty(dList[0].FilenameTR)) { %>
                            <div class="form-group">
                                <table border="0">
                                    <tr>
                                        <td style="width: 175px;"><%= dList.Count > 0 ? Developer.ShowFile(dList[0].FilenameTR) : "" %></td>
                                        <td><%= dList.Count > 0 ? Developer.DeleteFileButton("files", "Filename", dList[0].FilenameTR) : "" %></td>
                                    </tr>
                                </table>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("Dosya") %> - Türkçe</label>
                                <div class="custom-file">
                                    <input id="FilenameTR" class="custom-file-input form-data" type="file" data-crop="false" data-path="files" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
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
                            <% } %>
                            <div class="form-group">
                                <label><%= Language.GetFixed("KucukResim") %></label>
                                <div class="custom-file">
                                    <input id="Thumbnail" class="custom-file-input form-data" type="file" data-crop="false" data-path="images" />
                                    <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                                </div>
                            </div>
                        </div>

                        <!-- footer -->
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
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>