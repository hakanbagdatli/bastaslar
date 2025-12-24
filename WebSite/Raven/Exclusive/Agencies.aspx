<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Agencies.aspx.cs" Inherits="WebSite.Raven.Exclusive.Agencies" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="28" />
    <div class="container-fluid">
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
                                <a href="?dhx=all" class="btn btn-secondary font-weight-bold"><i class="la la-file-excel-o"></i>&nbsp;<%= Language.GetFixed("TumunuGor") %></a>
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
                                    <th><%= Language.GetFixed("AcentaAdi") %></th>
                                    <th><%= Language.GetFixed("YetkiliKisi") %></th>
                                    <th><%= Language.GetFixed("Telefon") %></th>
                                    <th><%= Language.GetFixed("IlgiliPersonel") %></th>
                                    <th><%= Language.GetFixed("Komisyon") %></th>
                                    <th><%= Language.GetFixed("Segmentasyon") %></th>
                                    <th><%= Language.GetFixed("Ulke") %></th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Sil") %></th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                    <th style="width: 150px;"><%= Language.GetFixed("Tarih") %></th>
                                    <th style="width: 200px;"><%= Language.GetFixed("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.Agencies> dList = Bll.Agencies.Select(0, filter: "", sorting: " CallbackCount DESC, id ASC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.Title %></td>
                                        <td><%= item.ContactName %></td>
                                        <td><%= item.ContactPhone %></td>
                                        <td><%= item._RelevantName + " " + item._RelevantSurname  %></td>
                                        <td><%= item.Commission  %></td>
                                        <td><%= item.Segmentation  %></td>
                                        <td><%= item.Country  %></td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckDel<%= item.id %>" name="isDeleted" type="checkbox" class="list-form-data" />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckApp<%= item.id %>" name="Approved" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Approved) ? "checked" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td><%= Utility.Helper.DateFormat(item.CreatedDate.ToString()) %></td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="?dhx=edit&id=<%= item.id %>" class="btn btn-outline-secondary font-weight-bold"><%= Language.GetFixed("Duzenle") %></a>
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-secondary font-weight-bold dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <%= Language.GetFixed("Islem") %>
                                                    </button>
                                                    <div class="dropdown-menu">
                                                        <a href="<%= Developer.ConstantUrl("brokers") %>?catid=<%= item.id %>" title="<%= Language.GetFixed("Brokers") %>" class="dropdown-item">
                                                            <i class="la la-image mr-1"></i><%= Language.GetFixed("Brokers") %></a>
                                                        <a href="<%= Developer.ConstantUrl("callback") %>?catid=<%= item.id %>" title="<%= Language.GetFixed("Aranmalar") %>" class="dropdown-item">
                                                            <i class="la la-phone-volume mr-1"></i><%= Language.GetFixed("Aranmalar") %></a>
                                                         <% if (item.id > 1) { %>
                                                        <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="dropdown-item">
                                                            <i class="la la-trash mr-1"></i><%= Language.GetFixed("Sil") %></a>
                                                          <% } %>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    
                    <% } else if (Request["dhx"] == "all") { %>
                    
                    <!-- body -->
                    <div class="card-body">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">ID</th>
                                    <th><%= Language.GetFixed("AcentaAdi") %></th>
                                    <th><%= Language.GetFixed("IlgiliPersonel") %></th>
                                    <th><%= Language.GetFixed("AcentaTipi") %></th>
                                    <th><%= Language.GetFixed("UygulamaTuru") %></th>
                                    <th><%= Language.GetFixed("Komisyon") %></th>
                                    <th><%= Language.GetFixed("YetkiliKisi") %></th>
                                    <th><%= Language.GetFixed("Telefon") %></th>
                                    <th><%= Language.GetFixed("Email") %></th>
                                    <th><%= Language.GetFixed("Durum") %></th>
                                    <th><%= Language.GetFixed("Segmentasyon") %></th>
                                    <th><%= Language.GetFixed("Province") %></th>
                                    <th><%= Language.GetFixed("Ulke") %></th>
                                    <th><%= Language.GetFixed("AgreementDate") %></th>
                                    <th><%= Language.GetFixed("İsletmePiyasa") %></th>
                                    <th><%= Language.GetFixed("Tarafindan") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.Agencies> dList = Bll.Agencies.Select(0, filter: "", sorting: " CallbackCount DESC, id ASC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.Title %></td>
                                        <td><%= item._RelevantName + " " + item._RelevantSurname  %></td>
                                        <td><%= item.AgencyType %></td>
                                        <td><%= item.ApplicationType %></td>
                                        <td><%= item.Commission %></td>
                                        <td><%= item.ContactName %></td>
                                        <td><%= item.ContactPhone %></td>
                                        <td><%= item.ContactEmail %></td>
                                        <td><%= item.Statu  %></td>
                                        <td><%= item.Segmentation  %></td>
                                        <td><%= item.Province  %></td>
                                        <td><%= item.Country  %></td>
                                        <td><%= item.AgreementDate %></td>
                                        <td><%= item.OperatingMarket %></td>
                                        <td><%= item.IntroducedBy %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                        <% List<Entities.Agencies> dList = Bll.Agencies.Select(RecordID, filter: ""); %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("AcentaAdi") %> *</label>
                            <input id="Title" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Title : "" %>" required />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IlgiliPersonel") %> *</label>
                            <select id="RelevantID" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].RelevantID : 0 %>" required>
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <% List<Entities.zUsers> dataList = Bll.zUsers.Select(0, filter: " AND CatID=1 AND Statu=5 AND Approved=1");
                                    foreach (var items in dataList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].RelevantID == items.id ? " selected" : "" : "" %>><%= items.Name + " " + items.Surname %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("AcentaTipi") %> *</label>
                            <select id="AgencyType" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].AgencyType : "0" %>" required>
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <option value="Estate">Estate</option>
                                <option value="Freelance">Freelance</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("UygulamaTuru") %> *</label>
                            <select id="ApplicationType" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].ApplicationType : "0" %>" required>
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <option value="New">New</option>
                                <option value="Renewal">Renewal</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Komisyon") %> *</label>
                            <input id="Commission" class="form-control form-data" type="number" value="<%= RecordID > 0 ? dList[0].Commission : "0" %>" required />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("YetkiliKisi") %> *</label>
                            <input id="ContactName" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactName : "" %>" required />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Durum") %></label>
                            <select id="Statu" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].Statu : "Inprocess" %>">
                                <option value="Inprocess">Inprocess</option>
                                <option value="Active">Active</option>
                                <option value="Expired">Expired</option>
                                <option value="Not Interested">Not Interested</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Segmentasyon") %></label>
                            <select id="Segmentation" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].Segmentation : "0" %>">
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <option value="Bronze">Bronze</option>
                                <option value="Silver">Silver</option>
                                <option value="Gold">Gold</option>
                                <option value="Platinum">Platinum</option>
                                <option value="Diamond">Diamond</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IrtibatEmail") %></label>
                            <input id="ContactEmail" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactEmail : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IrtibatEmail") %> 2</label>
                            <input id="ContactEmail2" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactEmail2 : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IrtibatEmail") %> 3</label>
                            <input id="ContactEmail3" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactEmail3 : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IrtibatTelefon") %></label>
                            <input id="ContactPhone" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactPhone : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IrtibatTelefon") %> 2</label>
                            <input id="ContactPhone2" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactPhone2 : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Adres") %></label>
                            <textarea id="Address" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Address : "" %></textarea>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Sehir") %></label>
                            <input id="Province" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Province : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Ulke") %></label>
                            <input id="Country" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Country : "" %>"  />
                        </div>
                        <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].AgreementFile)) { %>
                        <div class="form-group">
                            <table border="0">
                                <tr>
                                    <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowAgencyFile(dList[0].AgreementFile) : "" %></td>
                                    <td><%= RecordID > 0 ? Developer.DeleteFileButton("agencies", "AgreementFile", dList[0].AgreementFile) : "" %></td>
                                </tr>
                            </table>
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("AnlasmaDosya") %></label>
                            <div class="custom-file">
                                <input id="AgreementFile" class="custom-file-input form-data" type="file" data-crop="false" data-path="agencies" />
                                <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("AnlasmaTarih") %></label>
                            <input id="AgreementDate" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].AgreementDate : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("AnlasmaBitisTarih") %></label>
                            <input id="AgreementExpireDate" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].AgreementExpireDate : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("İsletmePiyasa") %></label>
                            <input id="OperatingMarket" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].OperatingMarket : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Tarafindan") %></label>
                            <input id="IntroducedBy" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].IntroducedBy : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("MSNoPassport") %></label>
                            <input id="MsnoPassport" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].MsnoPassport : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("InstagramAdres") %></label>
                            <input id="Instagram" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Instagram : "" %>" />
                        </div>
                        <!--<div class="form-group">
                            <label><%= Language.GetFixed("FacebookAdres") %></label>
                            <input id="Facebook" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Facebook : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("LinkedinAdres") %></label>
                            <input id="Linkedin" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Linkedin : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("YoutubeAdres") %></label>
                            <input id="Youtube" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Youtube : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("TwiterAdres") %></label>
                            <input id="Twitter" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Twitter : "" %>" />
                        </div>-->
                        <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].CompanyLogo)) { %>
                        <div class="form-group">
                            <table border="0">
                                <tr>
                                    <td style="width: 175px;"><%=  RecordID > 0 ? Developer.ShowImage(dList[0].CompanyLogo) : "" %></td>
                                    <td><%=  RecordID > 0 ? Developer.DeleteFileButton("agencies", "CompanyLogo", dList[0].CompanyLogo) : "" %></td>
                                </tr>
                            </table>
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Resim") %></label>
                            <div class="custom-file">
                                <input id="CompanyLogo" class="custom-file-input form-data" type="file" data-crop="true" data-path="agencies" />
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
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script src="/raven/assets/vendors/app.calback.js?v<%= Utility.Feature.Version %>"></script>
</asp:Content>