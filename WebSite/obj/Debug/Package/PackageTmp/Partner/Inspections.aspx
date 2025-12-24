<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Inspections.aspx.cs" Inherits="WebSite.Partner.Inspections" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">

                <!-- header -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-header flex-wrap py-3">
                        <div class="card-title">
                            <div class="d-block text-muted pt-2 font-size-sm">
                                <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                                    <li class="breadcrumb-item"><a href="/partner/" class="text-muted"><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= TurID == 0 ? Language.GetPartner("Gosterimler") : Language.GetPartner("Gorunum") %></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-toolbar">
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <% if (Request["dhx"] == null) { %>
                                <a href="?dhx=add&type=<%= TurID %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetPartner("YeniKayit") %></a>
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
                    
                    <input id="sadas" type="hidden" value="<%= whereClause %>" />
                    <!-- body -->
                    <div class="card-body" style="overflow-x:auto">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinTable">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">ID</th>
                                    <th><%= Language.GetPartner("TakipNo") %></th>
                                    <th><%= Language.GetPartner("AcentaAdi") %></th>
                                    <th><%= Language.GetPartner("SunumTarihi") %></th>
                                    <th><%= Language.GetPartner("MusteriBilgi") %></th>
                                    <th><%= Language.GetPartner("Proje") %></th>
                                    <th><%= Language.GetPartner("Durum") %></th>
                                    <th style="width: 150px;"><%= Language.GetPartner("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.Inspections> dList = Bll.Inspections.Select(0, filter: whereClause, sorting: " id DESC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.PNRCode  %></td>
                                        <td><%= item._AgencyName %></td>
                                        <td><%= Utility.Helper.SiteDateFormat(item.PresentationDate) + " - " + item.PresentationTime %></td>
                                        <td><%= string.Join(", ", Bll.Attendees.Select(0, " AND id in (" + item.Clients + ")").ToList().Select(attend => attend.Fullname)) %></td>
                                        <td><%= string.Join(", ", item._Projects.Select(project => project.Title)) %></td>
                                        <td><span class="label label-lg label-light-<%= item._StatuColor %> label-inline"><%= item._Statu.ToLower() %></span></td>
                                        <td>
                                            <a href="?dhx=edit&id=<%= item.id %>&type=<%= item.TurID %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetPartner("Duzenle") %>"><i class="la la-edit"></i></a>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <input id="table" class="form-control" type="hidden" value="32" />
                        <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                        <input id="TurID" class="form-control form-data" type="hidden" value="<%= TurID %>" />
                        <% if (UserData.CatID == 1 && (Request["dhx"] != "edit")) { %>
                        <input id="Statu" class="form-control form-data" type="hidden" value="2" />
                        <% } %>
                        <% List<Entities.Inspections> dList = Bll.Inspections.Select(RecordID, filter: ""); %>  
                        <input id="PNRCode" class="form-control form-data" type="hidden" value="<%= RecordID > 0 ? dList[0].PNRCode : (TurID == 0 ? Function.GeneratePNR("ISP") : Function.GeneratePNR("PRV")) %>" />
                        <% if (UserData.CatID == 1) { %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("AcentaAdi") %> *</label>
                            <select id="AgencyID" class="form-control form-data form-data-option selectpicker" data-live-search="true" data-value="<%= RecordID > 0 ? dList[0].AgencyID.ToString() : "0" %>" required>
                                <option value="0"><%= Language.GetPartner("LutfenSec") %></option>
                                <% List<Entities.Agencies> customerList = Bll.Agencies.Select(0, filter: " AND Approved=1 AND RelevantID=" + UserData.id);
                                    foreach (var items in customerList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].AgencyID == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
                        </div>
                        <% } else { %> 
                        <input id="AgencyID" class="form-control form-data" type="hidden" value="<%= UserData.CatID %>" />
                        <% } %>
                       <div class="form-group">
                            <label><%= Language.GetPartner("IlgiliProje") %></label>
                            <select id="ProjectID" class="form-control form-data form-data-option multiselect" multiple required>
                                <%  ArrayList projList = new ArrayList();
                                    if (RecordID > 0)
                                        projList = Utility.Helper.SplitedList(",", dList[0].ProjectID);
                                    var _idList = Select.MultipleCategoryID(3).Split(',').Select(int.Parse).ToList();
                                    List<Entities.GeneralRecords> projectList = Entities.StaticList.Records.Where(x => (_idList.Contains(x.CatID)) && (x.Approved == 1)).ToList();
                                    foreach (var items in projectList) { %>
                                    <option value="<%= items.id %>" <%= inList(projList, items.id) ? " selected" : "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
                        </div>
                        <% if (TurID == 0) { %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("AcentaTemsilcisi") %></label>
                            <input id="AttendingAgentPersonal" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].AttendingAgentPersonal : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("SunumuYapan") %></label>
                            <select id="Presenter" class="form-control form-data form-data-option selectpicker" data-live-search="true" data-value="<%= RecordID > 0 ? dList[0].Presenter : 0 %>" required>
                                <option value="0"><%= Language.GetPartner("LutfenSec") %></option>
                                <% List<Entities.zUsers> dataList = Bll.zUsers.Select(0, filter: " AND CatID=1 AND Statu=5 AND Approved=1");
                                    foreach (var items in dataList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].Presenter == items.id ? " selected" : "" : "" %>><%= items.Name + " " + items.Surname %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("OnSunumTarihi") %></label>
                            <input id="PrePresentationDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].PrePresentationDate : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("OnSunumSaati") %></label>
                            <input id="PrePresentationTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].PrePresentationTime : "" %>"  />
                        </div>
                        <hr />
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label><%= Language.GetPartner("KonaklamaCheckinTarihi") %></label>
                                <input id="CheckinDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].CheckinDate : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%= Language.GetPartner("KonaklamaCheckinSaati") %></label>
                                <input id="CheckinTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].CheckinTime : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%=Language.GetPartner("KonaklamaCheckoutTarihi") %></label>
                                <input id="CheckoutDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].CheckoutDate : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%= Language.GetPartner("KonaklamaCheckoutSaati") %></label>
                                <input id="CheckoutTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].CheckoutTime : "" %>" />
                            </div>
                            <div class="form-group col-md-12">
                                <p>* <%= Language.GetPartner("KonaklamaAciklama") %></p>
                            </div>
                        </div>
                        <% } %>
                        <hr />
                        <% if (TurID == 1) { %>
                       <div class="form-group">
                            <label><%= Language.GetPartner("GorunumTuru") %></label>
                            <select id="PropertyViewType" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PropertyViewType.ToString() : "1" %>">
                               <option value="0"><%= Language.GetPartner("Sunum") %></option>
                               <option value="1"><%= Language.GetPartner("SunumZiyaret") %></option>
                               <option value="2"><%= Language.GetPartner("AcentaZiyareti") %></option>
                            </select>
                        </div>
                        <% } %>
                        <% if (UserData.CatID == 1) { %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("ToplantiOdasi") %> *</label>
                            <select id="MeetingRoomID" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].MeetingRoomID : 16 %>" required>
                                <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 5))) { %>
                                <option value="<%= items.id %>" <%= RecordID > 0 && dList[0].Statu == items.id ? " selected" :  "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("SunumTarihi") %> *</label>
                            <input id="PresentationDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].PresentationDate : "" %>" required />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("SunumSaati") %> *</label>
                            <input id="PresentationTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].PresentationTime : "" %>" required />
                        </div>
                        <% if (TurID == 0) { %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("YemekIsterMi") %></label>
                            <select id="hasLaunch" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].hasLaunch.ToString() : "0" %>">
                                <option value="0"><%= Language.GetPartner("Hayir") %></option>
                                <option value="1"><%= Language.GetPartner("Evet") %></option>
                            </select>
                            <small>* <%=Language.GetPartner("YemekIsterMiAciklama") %></small>
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("YetiskenMusteriSayisi") %></label>
                            <input id="AdultCount" class="form-control form-data" type="number" value="<%= RecordID > 0 ? dList[0].AdultCount : 1 %>" required />
                        </div>
                        <% if (RecordID == 0) { %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("MusteriAdi") %> *</label>
                            <input id="Clients" class="form-control form-data" type="text" required />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("AliciMilliyeti") %></label>
                            <input id="Nationality" class="form-control form-data" type="text" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Meslek") %></label>
                            <input id="Occupation" class="form-control form-data" type="text" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("SatinAlmaAmaci") %></label>
                            <select id="PurposeThePurchase" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PurposeThePurchase : 0 %>">
                                <option value="0"><%= Language.GetPartner("DaimiIkamet") %></option>
                                <option value="1"><%= Language.GetPartner("TatilEvi") %></option>
                                <option value="2"><%= Language.GetPartner("YatirimAmacli") %> </option>
                                <option value="3"><%= Language.GetPartner("Diger") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("İlgiliMulkTuru") %></label>
                            <select id="InterestedPropertyType" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].InterestedPropertyType : 0 %>">
                                <option value="0">Apartment</option>
                                <option value="1">Villa</option>
                                <option value="2">Bungalow</option>
                                <option value="3"><%= Language.GetPartner("Tumu") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("BelirliOzellikler") %></label>
                            <select id="SpecificAmenities" class="form-control form-data form-data-option multiselect" multiple data-value="<%= RecordID > 0 ? dList[0].SpecificAmenities : "" %>">
                                <option value="0"><%= Language.GetPartner("YuzmeHavuzu") %></option>
                                <option value="1"><%= Language.GetPartner("DenizManzarasi") %></option>
                                <option value="2"><%= Language.GetPartner("Bahce") %></option>
                                <option value="3"><%= Language.GetPartner("DagManzarasi") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%=Language.GetPartner("InsaatHalindeTamamlanmis") %></label>
                            <select id="ProjectPhase" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].ProjectPhase : 0 %>">
                                <option value="1"><%= Language.GetPartner("Evet") %></option>
                                <option value="0"><%= Language.GetPartner("Hayir") %></option>
                                <option value="2"><%= Language.GetPartner("Tumu") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("MusteriButcesi") %> *</label>
                            <input id="ClientsBudget" class="form-control form-data" type="text" required />
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("IrtibatTelefon") %> 1</label>
                            <input id="ContactNo1" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactNo1 : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("IrtibatTelefon") %> 2</label>
                            <input id="ContactNo2" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactNo2 : "" %>" />
                        </div>
                        <% if (RecordID > 0 && !String.IsNullOrEmpty(dList[0].Passports)) { %>
                        <div class="form-group">
                            <table border="0">
                                <tr>
                                    <td style="width: 175px;"><%= RecordID > 0 ? Developer.ShowImage(dList[0].Passports) : "" %></td>
                                    <td><%= RecordID > 0 ? Developer.DeleteFileButton("files", "Passports", dList[0].Passports) : "" %></td>
                                </tr>
                            </table>
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("Pasaport") %></label>
                            <div class="custom-file">
                                <input id="Passports" class="custom-file-input form-data" type="file" data-crop="false" data-path="files" />
                                <label class="custom-file-label" for="customFile"><%= Language.GetPartner("DosyaSec") %></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("TercihEdilenDil") %></label>
                            <select id="PreferredLanguage" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PreferredLanguage.ToString() : "0" %>" required>
                                <option value="0"><%= Language.GetPartner("LutfenSec") %></option>
                                <option value="English">English</option>
                                <option value="German">German</option>
                                <option value="Persian">Persian</option>
                                <option value="Russian">Russian</option>
                                <option value="Turkish">Turkish</option>
                            </select>
                        </div>
                        <% if (TurID == 0) { %>
                        <div class="form-group">
                            <label><%= Language.GetPartner("CocukMusteriSayisi") %></label>
                            <select id="hasChild" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].hasChild.ToString() : "0" %>">
                                <option value="0"><%= Language.GetPartner("Hayir") %></option>
                                <option value="1"><%= Language.GetPartner("Evet") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("CocukBilgisi") %></label>
                            <textarea id="ChildrenInformation" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ChildrenInformation : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("HavaalaniVarisTransferi") %></label>
                            <select id="hasArrivalTransfer" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].hasArrivalTransfer.ToString() : "0" %>">
                                <option value="0"><%= Language.GetPartner("Hayir") %></option>
                                <option value="1"><%= Language.GetPartner("Evet") %></option>
                            </select>
                            <small>* <%= Language.GetPartner("HavaalaniTransferiAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label><%=Language.GetPartner("VarisHavaalani") %></label>
                            <select id="ArrivalAirport" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].ArrivalAirport.ToString() : "0" %>">
                                <option value="0"><%= Language.GetPartner("LutfenSec") %></option>
                                <option value="Ercan">Ercan</option>
                                <option value="Larnaca">Larnaca</option>
                                <option value="Paphos">Paphos</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("UcusNumarasi") %></label>
                            <input id="ArrivalFlightNumber" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ArrivalFlightNumber : "" %>" />
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label><%= Language.GetPartner("VarisTarihi") %></label>
                                <input id="ArrivalDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].ArrivalDate : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%= Language.GetPartner("VarisSaati") %></label>
                                <input id="ArrivalTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].ArrivalTime : "" %>" />
                            </div>
                        </div>
                        <hr />
                        <div class="form-group">
                            <label><%= Language.GetPartner("HavalaniDönüsTransferi") %></label>
                            <select id="hasDepartureTransfer" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].hasDepartureTransfer.ToString() : "0" %>">
                                <option value="0"><%= Language.GetPartner("Hayir") %></option>
                                <option value="1"><%= Language.GetPartner("Evet") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("DonusHavaalani") %></label>
                            <select id="DepartureAirport" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].DepartureAirport.ToString() : "0" %>">
                                <option value="0"><%= Language.GetPartner("LutfenSec") %></option>
                                <option value="Ercan">Ercan</option>
                                <option value="Larnaca">Larnaca</option>
                                <option value="Paphos">Paphos</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("UcusNumarasi") %></label>
                            <input id="DepartureFlightNumber" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].DepartureFlightNumber : "" %>" />
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label><%= Language.GetPartner("DonusTarihi") %></label>
                                <input id="DepartureDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].DepartureDate : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%= Language.GetPartner("DonusSaati") %></label>
                                <input id="DepartureTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].DepartureTime : "" %>" />
                            </div>
                        </div>
                        <hr />
                        <div class="form-group">
                            <label><%= Language.GetPartner("ProgramTakvimTamam") %></label>
                            <select id="isScheduleCompleted" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].isScheduleCompleted : 0 %>">
                                <option value="0"><%= Language.GetPartner("Hayir") %></option>
                                <option value="1"><%= Language.GetPartner("Evet") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetPartner("SunumMusterileMi") %></label>
                            <select id="isPresentationCompleted" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].isPresentationCompleted : 0 %>">
                                <option value="0"><%= Language.GetPartner("Hayir") %></option>
                                <option value="1"><%= Language.GetPartner("Evet") %></option>
                            </select>
                        </div>
                        <% } %>
                        <hr />
                        <div class="form-group">
                            <label><%= Language.GetPartner("Not") %></label>
                            <textarea id="Message" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Message : "" %></textarea>
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
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script src="/raven/assets/js/tagify.js?v=<%= Utility.Feature.Version %>"></script>
    <script type="text/javascript">
        $("#CheckinDate").change(function () {
            let selectedDate = $(this).val();
            var newDate = new Date(selectedDate);
            newDate.setDate(newDate.getDate() + 2);
            $("#CheckoutDate").attr("min", selectedDate);
            $("#CheckoutDate").attr("max", newDate.toISOString().split('T')[0]);
            $("#PresentationDate").attr("min", selectedDate);
            $("#PresentationDate").attr("max", newDate.toISOString().split('T')[0]);
        });
    </script>
</asp:Content>