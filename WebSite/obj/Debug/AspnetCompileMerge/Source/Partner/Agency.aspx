<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Agency.aspx.cs" Inherits="WebSite.Partner.Agency" %>
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
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= Language.GetPartner("AcentaList") %></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-toolbar">
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
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
                                    <th><%= Language.GetPartner("YetkiliKisi") %></th>
                                    <th><%= Language.GetPartner("Telefon") %></th>
                                    <th><%= Language.GetPartner("Email") %></th>
                                    <th><%= Language.GetPartner("Komisyon") %></th>
                                    <th><%= Language.GetPartner("Durum") %></th>
                                    <th style="width: 300px;"><%= Language.GetPartner("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.Agencies> dList = Bll.Agencies.Select(0, filter: " AND RelevantID=" + UserData.id, sorting: " CallbackCount ASC, id DESC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.Title %></td>
                                        <td><%= item.ContactName %></td>
                                        <td><%= item.ContactPhone %></td>
                                        <td><%= item.ContactEmail %></td>
                                        <td><%= item.Commission  %></td>
                                        <td><%= Function.AgencyStatuBadge(item.Statu)  %></td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="javascript:;" class="btn-callback btn btn-outline-secondary font-weight-bold" title="Touch" data-id="<%= item.id %>">
                                                    <i class="la la-phone-volume"></i>Touch</a>
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-secondary font-weight-bold dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <%= Language.GetPartner("Islem") %>
                                                    </button>
                                                    <div class="dropdown-menu">
                                                        <a  href="?dhx=edit&id=<%= item.id %>" class="dropdown-item">
                                                            <i class="la la-user mr-1"></i><%= Language.GetPartner("Onizle") %></a>
                                                        <a href="<%= Developer.ConstantUrl("pcustomers") %>?catid=<%= item.id %>" class="dropdown-item">
                                                            <i class="la la-user mr-1"></i><%= Language.GetPartner("Musteriler") %></a>
                                                        <a href="<%= Developer.ConstantUrl("pinspection") %>&catid=<%= item.id %>"  class="dropdown-item">
                                                            <i class="la la-calendar mr-1"></i><%= Language.GetPartner("Gosterimler") %></a>
                                                        <a href="<%= Developer.ConstantUrl("ppview") %>&catid=<%= item.id %>" class="dropdown-item">
                                                            <i class="la la-calendar mr-1"></i><%= Language.GetPartner("Gorunum") %></a>
                                                        <a href="<%= Developer.ConstantUrl("preservations") %>?catid=<%= item.id %>" class="dropdown-item">
                                                            <i class="la la-calendar-check-o mr-1"></i><%= Language.GetPartner("Rezervasyon") %></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <% List<Entities.Agencies> dList = Bll.Agencies.Select(0, filter: " AND id=" + RecordID + " AND RelevantID=" + UserData.id); %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("KayitliSirketAdi") %></label>
                            <input id="Title" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Title : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("YetkiliKisi") %></label>
                            <input id="ContactName" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactName : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("IrtibatEmail") %></label>
                            <input id="ContactEmail" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactEmail : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("IrtibatEmail") %> 2</label>
                            <input id="ContactEmail2" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactEmail2 : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("IrtibatEmail") %> 3</label>
                            <input id="ContactEmail3" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactEmail3 : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("IrtibatTelefon") %></label>
                            <input id="ContactPhone" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactPhone : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("IrtibatTelefon") %> 2</label>
                            <input id="ContactPhone2" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactPhone2 : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Adres") %></label>
                            <textarea id="Address" class="form-control form-data" rows="4"><%= dList[0].Address %></textarea>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Sehir") %></label>
                            <input id="Province" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Province : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Ulke") %></label>
                            <input id="Country" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Country : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Komisyon") %></label>
                            <input id="Commission" class="form-control form-data" type="number" value="<%= RecordID > 0 ? dList[0].Commission : "0" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("InstagramAdres") %></label>
                            <input id="Instagram" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Instagram : "" %>"  disabled />
                        </div>
                        <!--<div class="form-group">
                            <label><%= Language.GetPartner("FacebookAdres") %></label>
                            <input id="Facebook" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Facebook : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("LinkedinAdres") %></label>
                            <input id="Linkedin" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Linkedin : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("YoutubeAdres") %></label>
                            <input id="Youtube" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Youtube : "" %>" disabled />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("TwiterAdres") %></label>
                            <input id="Twitter" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].Twitter : "" %>" disabled />
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
                    </div>

                    <% } %>

                </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script src="/raven/assets/vendors/app.calback.js?v<%= Utility.Feature.Version %>"></script>
    <div class="modal fade" id="CalbackModal" tabindex="-1" role="dialog" aria-labelledby="CalbackModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <input id="CallbackID" type="hidden" class="form-control" value="0" />
                    <div class="form-group">
                        <label><%= Language.GetPartner("AranmaTipi") %></label>
                        <select id="CallbackType" class="form-control">
                            <option>Phone</option>
                            <option>Email</option>
                            <option>Whatsapp</option>
                            <option>Face to Face</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><%= Language.GetPartner("KisaIcerik") %></label>
                        <textarea id="Description" class="form-control" rows="4"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"><%= Language.GetPartner("Iptal") %></button>
                    <button type="button" class="btn btn-primary btn-save-callback"><%= Language.GetPartner("Kaydet") %></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>