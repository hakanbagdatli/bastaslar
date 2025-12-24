<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="WebSite.Partner.Customers" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">

                <!-- header -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-header flex-wrap py-3">
                        <div class="card-title">
                            <div class="d-block text-muted pt-2 font-size-sm">
                                <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                                    <li class="breadcrumb-item"><a href="/partner/" class="text-muted"><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= Language.GetPartner("Musteriler") %></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-toolbar">
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <% if (Request["dhx"] == null) { %>
                                <a href="?dhx=add" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetPartner("YeniKayit") %></a>
                                <% } else { %>
                                <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetPartner("Kaydet") %></a>
                                <% } %>
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetPartner("GeriDon") %></a>
                            </div>
                        </div>
                    </div>
                </div>
                    
                <!-- body -->
                <div class="card card-custom gutter-b example example-compact">
                    <% if (Request["dhx"] == null) { %>

                    <!-- body -->
                    <div class="card-body" style="overflow-x:auto">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">ID</th>
                                    <th><%= Language.GetPartner("AcentaAdi") %></th>
                                    <th><%= Language.GetPartner("AdSoyad") %></th>
                                    <th><%= Language.GetPartner("Telefon") %></th>
                                    <th><%= Language.GetPartner("Email") %></th>
                                    <th><%= Language.GetPartner("Ulke") %></th>
                                    <th style="width: 100px;"><%= Language.GetPartner("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.Customers> dList = Bll.Customers.Select(0, filter: whereClause);
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item._AgencyName  %></td>
                                        <td><%= item.Name +  " " + item.Surname  %></td>
                                        <td><%= item.Phone  %></td>
                                        <td><%= item.Email  %></td>
                                        <td><%= item.Country  %></td>
                                        <td>
                                            <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetPartner("Duzenle") %>"><i class="la la-edit"></i></a>
                                            <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetPartner("Sil") %>"><i class="la la-trash"></i></a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <input id="table" class="form-control" type="hidden" value="30" />
                        <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                        <% List<Entities.Customers> dList = Bll.Customers.Select(RecordID, filter: ""); %>
                        <% if (UserData.CatID == 1) { %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("AcentaAdi") %></label>
                            <select id="AgencyID" class="form-control form-data form-data-option selectpicker" data-live-search="true" data-value="<%= RecordID > 0 ? dList[0].AgencyID.ToString() : "0" %>">
                                <option value="0"><%= Language.GetPartner("LutfenSec") %></option>
                                <% List<Entities.Agencies> agencyList = Bll.Agencies.Select(0, filter: " AND Approved=1 AND RelevantID=" + UserData.id);
                                    foreach (var items in agencyList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].AgencyID == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
                        </div>
                        <% } else { %> 
                        <input id="AgencyID" class="form-control form-data" type="hidden" value="<%= UserData.CatID %>" />
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Ad") %></label>
                            <input id="Name" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Name : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Soyad") %></label>
                            <input id="Surname" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Surname : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Email") %></label>
                            <input id="Email" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Email : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Telefon") %></label>
                            <input id="Phone" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Phone : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Cinsiyet") %></label>
                            <select id="Gender" class="form-control form-data form-data-option">
                                <option value="0" <%= RecordID > 0 ? (dList[0].Gender.ToString() == "0" ? "selected" : "") : "" %>><%= Language.GetPartner("LutfenSec") %></option>
                                <option value="1" <%= RecordID > 0 ? (dList[0].Gender.ToString() == "1" ? "selected" : "") : "" %>><%= Language.GetPartner("Erkek") %></option>
                                <option value="2" <%= RecordID > 0 ? (dList[0].Gender.ToString() == "2" ? "selected" : "") : "" %>><%= Language.GetPartner("Kadin") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("DogumTarih") %></label>
                            <input id="Birthday" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Phone : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Ulke") %></label>
                            <input id="Country" class="form-control form-data" type="text" value="<%= dList.Count > 0 ? dList[0].Phone : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("KisaIcerik") %></label>
                            <textarea id="ShortContent" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ShortContent : ""%></textarea>
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
                            <label><%= Language.GetPartner("Resim") %></label>
                            <div class="custom-file">
                                <input id="Image" class="custom-file-input form-data" type="file" data-crop="true" data-path="images" />
                                <label class="custom-file-label" for="customFile"><%= Language.GetPartner("DosyaSec") %></label>
                            </div>
                        </div>
                    </div>

                    <!-- footer -->
                    <div class="card-footer">
                        <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetPartner("Kaydet") %></a>
                        <a href="javascript:;" class="btn btn-secondary font-weight-bold" onclick="window.history.back()">&nbsp;<%= Language.GetPartner("GeriDon") %></a>
                    </div>

                    <% } %>

                </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>