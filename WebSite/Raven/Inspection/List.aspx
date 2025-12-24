<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="WebSite.Raven.Inspection.List" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="32" />
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
                                <a href="?dhx=add&catid=<%= CatID %>&turid=<%= TurID %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
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
                                    <th><%= Language.GetFixed("TakipNo") %></th>
                                    <th><%= Language.GetFixed("SunumTarihi") %></th>
                                    <th><%= Language.GetFixed("AcentaAdi") %></th>
                                    <th><%= Language.GetFixed("MusteriAdi") %></th>
                                    <th><%= Language.GetFixed("IlgiliPersonel") %></th>
                                    <th><%= Language.GetFixed("Proje") %></th>
                                    <th style="width: 50px;"><%= Language.GetFixed("Onay") %></th>
                                    <th><%= Language.GetFixed("Durum") %></th>
                                    <th style="width: 150px;"><%= Language.GetFixed("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Entities.Inspections> dList = Bll.Inspections.Select(0, filter: whereClause, sorting: " id DESC");
                                    foreach (var item in dList) { %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><%= item.PNRCode  %></td>
                                        <td><%= Utility.Helper.SiteDateFormat(item.PresentationDate) + " - " + item.PresentationTime %></td>
                                        <td><%= item._AgencyName %></td>
                                        <td><%= string.Join(", ", Bll.Attendees.Select(0, " AND id in (" + item.Clients + ")").ToList().Select(attend => attend.Fullname)) %></td>
                                        <td><%= item._SaleExecutive %></td>
                                        <td><%= string.Join(", ", item._Projects.Select(project => project.Title)) %></td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckApp<%= item.id %>" name="Approved" type="checkbox" class="list-form-data" <%= Convert.ToBoolean(item.Approved) ? "checked" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
											<span class="label label-lg label-light-<%= item._StatuColor %> label-inline"><%= item._Statu.ToLower() %></span>
										</td>
                                        <td>
                                            <a href="?dhx=edit&id=<%= item.id %>&turid=<%= item.TurID %>" class="btn btn-sm btn-clean btn-icon mr-2" title="<%= Language.GetFixed("Duzenle") %>"><i class="la la-edit"></i></a>
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
                        <input id="TurID" class="form-control form-data" type="hidden" value="<%= TurID %>" />
                        <% List<Entities.Inspections> dList = Bll.Inspections.Select(RecordID, filter: ""); %>  
                        <input id="PNRCode" class="form-control form-data" type="hidden" value="<%= RecordID > 0 ? dList[0].PNRCode : 
                                (TurID == 0 ? Function.GeneratePNR("ISP") : Function.GeneratePNR("PRV")) %>" />
                        <div class="form-group">
                            <label><%= Language.GetFixed("AcentaAdi") %> *</label>
                            <div class="input-group">
                                <select id="AgencyID" class="form-control form-data form-data-option selectpicker" data-live-search="true" data-value="<%= RecordID > 0 ? dList[0].AgencyID.ToString() : "0" %>" required>
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% List<Entities.Agencies> customerList = Bll.Agencies.Select(0, filter: " AND Approved=1");
                                        foreach (var items in customerList) { %>
                                        <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].AgencyID == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                                <div class="input-group-append">
									<a href="<%= Developer.ConstantUrl("agency") %>?dhx=add" target="_blank" class="btn btn-secondary">
                                        <i class="la la-plus-circle"></i>
									</a>
								</div>
							</div>
                        </div>
                        <% if (TurID == 0) { %>
                        <div class="form-group">
                            <label>Name of authorized Agent attending</label>
                            <input id="AttendingAgentPersonal" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].AttendingAgentPersonal : "" %>"  />
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IlgiliProje") %> *</label>
                            <select id="ProjectID" class="form-control form-data form-data-option multiselect" multiple required>
                                <%  ArrayList projList = new ArrayList();
                                    if (RecordID > 0)
                                        projList = Utility.Helper.SplitedList(",", dList[0].ProjectID);
                                    var _idList = Select.MultipleCategoryID(3).Split(',').Select(int.Parse).ToList();
                                    List<Entities.GeneralRecords> projectList = StaticList.Records.Where(x => (_idList.Contains(x.CatID)) && (x.Approved == 1)).ToList();
                                    foreach (var items in projectList) { %>
                                    <option value="<%= items.id %>" <%= inList(projList, items.id) ? " selected" : "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
                        </div>
                        <% if (TurID == 0) { %>
                        <div class="form-group">
                            <label>Presenter</label>
                            <select id="Presenter" class="form-control form-data form-data-option selectpicker" data-live-search="true" data-value="<%= RecordID > 0 ? dList[0].Presenter : 0 %>" required>
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <% List<Entities.zUsers> dataList = Bll.zUsers.Select(0, filter: " AND CatID=1 AND Statu=5 AND Approved=1");
                                    foreach (var items in dataList) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].Presenter == items.id ? " selected" : "" : "" %>><%= items.Name + " " + items.Surname %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Pre Presentation Date</label>
                            <input id="PrePresentationDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].PrePresentationDate : "" %>"  />
                        </div>
                        <div class="form-group">
                            <label>Pre Presentation Time</label>
                            <input id="PrePresentationTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].PrePresentationTime : "" %>"  />
                        </div>
                        <hr />
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label><%= Language.GetFixed("KonaklamaCheckinTarihi") %></label>
                                <input id="CheckinDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].CheckinDate : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%= Language.GetFixed("KonaklamaCheckinSaati") %></label>
                                <input id="CheckinTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].CheckinTime : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%=Language.GetFixed("KonaklamaCheckoutTarihi") %></label>
                                <input id="CheckoutDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].CheckoutDate : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%= Language.GetFixed("KonaklamaCheckoutSaati") %></label>
                                <input id="CheckoutTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].CheckoutTime : "" %>" />
                            </div>
                            <div class="form-group col-md-12">
                                <p>* <%= Language.GetFixed("KonaklamaAciklama") %></p>
                            </div>
                        </div>
                        <% } %>
                        <hr />
                        <% if (TurID == 1) { %>
                        <div class="form-group">
                            <label>Property View Type</label>
                            <select id="PropertyViewType" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PropertyViewType.ToString() : "1" %>">
                                <option value="0">Presentation</option>
                                <option value="1">View and Presentation</option>
                                <option value="2">Agency Property View</option>
                            </select>
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label>Meeting Room *</label>
                            <select id="MeetingRoomID" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].MeetingRoomID : 16 %>" required>
                                <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 5))) { %>
                                <option value="<%= items.id %>" <%= RecordID > 0 && dList[0].Statu == items.id ? " selected" :  "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("SunumTarihi") %> *</label>
                            <input id="PresentationDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].PresentationDate : "" %>" required />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("SunumSaati") %> *</label>
                            <input id="PresentationTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].PresentationTime : "" %>" required />
                        </div>
                        <% if (TurID == 0) { %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("YemekIsterMi") %></label>
                            <select id="hasLaunch" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].hasLaunch.ToString() : "0" %>">
                                <option value="0">No</option>
                                <option value="1">Yes</option>
                            </select>
                            <small>* <%=Language.GetFixed("YemekIsterMiAciklama") %></small>
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("YetiskenMusteriSayisi") %> *</label>
                            <input id="AdultCount" class="form-control form-data" type="number" value="<%= RecordID > 0 ? dList[0].AdultCount : 1 %>" required />
                        </div>
                        <% if (RecordID == 0) { %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("MusteriAdi") %> *</label>
                            <input id="Clients" class="form-control form-data" type="text" required />
                        </div>
                        <div class="form-group">
                            <label>Nationality</label>
                            <input id="Nationality" class="form-control form-data" type="text" />
                        </div>
                        <div class="form-group">
                            <label>Occupation</label>
                            <input id="Occupation" class="form-control form-data" type="text" />
                        </div>
                        <div class="form-group">
                            <label>What is the Purpose to Purchase?</label>
                            <select id="PurposeThePurchase" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PurposeThePurchase : 0 %>">
                                <option value="0">Permanent residence</option>
                                <option value="1">Holiday home (Lifestyle)</option>
                                <option value="2">Investment property </option>
                                <option value="3">Other (please specify)</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>What type of property are they interested in?</label>
                            <select id="InterestedPropertyType" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].InterestedPropertyType : 0 %>">
                                <option value="0">Apartment</option>
                                <option value="1">Villa</option>
                                <option value="2">Bungalow</option>
                                <option value="3">All</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Do you require specific amenities or features? (Check all that apply)</label>
                            <select id="SpecificAmenities" class="form-control form-data form-data-option multiselect" multiple data-value="<%= RecordID > 0 ? dList[0].SpecificAmenities : "" %>">
                                <option value="0">Swimming pool</option>
                                <option value="1">Sea view</option>
                                <option value="2">Garden</option>
                                <option value="3">Mountain View</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Are they interested in a property that is under construction or completed?</label>
                            <select id="ProjectPhase" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].ProjectPhase : 0 %>">
                                <option value="1">Yes</option>
                                <option value="0">No</option>
                                <option value="2">Both</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("MusteriButcesi") %> *</label>
                            <input id="ClientsBudget" class="form-control form-data" type="text" required />
                        </div>
                        <% } %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IrtibatTelefon") %> 1</label>
                            <input id="ContactNo1" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ContactNo1 : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IrtibatTelefon") %> 2</label>
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
                            <label><%= Language.GetFixed("Pasaport") %></label>
                            <div class="custom-file">
                                <input id="Passports" class="custom-file-input form-data" type="file" data-crop="false" data-path="files" />
                                <label class="custom-file-label" for="customFile"><%= Language.GetFixed("DosyaSec") %></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("TercihEdilenDil") %> *</label>
                            <select id="PreferredLanguage" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PreferredLanguage.ToString() : "0" %>" required>
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <option value="English">English</option>
                                <option value="German">German</option>
                                <option value="Persian">Persian</option>
                                <option value="Russian">Russian</option>
                                <option value="Turkish">Turkish</option>
                            </select>
                        </div>
                        <% if (TurID == 0) { %>
                        <div class="form-group">
                            <label><%= Language.GetFixed("CocukMusteriSayisi") %></label>
                            <select id="hasChild" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].hasChild.ToString() : "0" %>">
                                <option value="0">No</option>
                                <option value="1">Yes</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("CocukBilgisi") %></label>
                            <textarea id="ChildrenInformation" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ChildrenInformation : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("HavaalaniVarisTransferi") %></label>
                            <select id="hasArrivalTransfer" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].hasArrivalTransfer.ToString() : "0" %>">
                                <option value="0">No</option>
                                <option value="1">Yes</option>
                            </select>
                            <small>* <%= Language.GetFixed("HavaalaniTransferiAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label><%=Language.GetFixed("VarisHavaalani") %></label>
                            <select id="ArrivalAirport" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].ArrivalAirport.ToString() : "0" %>">
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <option value="Ercan">Ercan</option>
                                <option value="Larnaca">Larnaca</option>
                                <option value="Paphos">Paphos</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("UcusNumarasi") %></label>
                            <input id="ArrivalFlightNumber" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].ArrivalFlightNumber : "" %>" />
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label><%= Language.GetFixed("VarisTarihi") %></label>
                                <input id="ArrivalDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].ArrivalDate : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%= Language.GetFixed("VarisSaati") %></label>
                                <input id="ArrivalTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].ArrivalTime : "" %>" />
                            </div>
                        </div>
                        <hr />
                        <div class="form-group">
                            <label><%= Language.GetFixed("HavalaniDönüsTransferi") %></label>
                            <select id="hasDepartureTransfer" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].hasDepartureTransfer.ToString() : "0" %>">
                                <option value="0">No</option>
                                <option value="1">Yes</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("DonusHavaalani") %></label>
                            <select id="DepartureAirport" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].DepartureAirport.ToString() : "0" %>">
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <option value="Ercan">Ercan</option>
                                <option value="Larnaca">Larnaca</option>
                                <option value="Paphos">Paphos</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("UcusNumarasi") %></label>
                            <input id="DepartureFlightNumber" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].DepartureFlightNumber : "" %>" />
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label><%= Language.GetFixed("DonusTarihi") %></label>
                                <input id="DepartureDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].DepartureDate : "" %>" />
                            </div>
                            <div class="form-group col-md-6">
                                <label><%= Language.GetFixed("DonusSaati") %></label>
                                <input id="DepartureTime" class="form-control form-data" type="time" value="<%= RecordID > 0 ? dList[0].DepartureTime : "" %>" />
                            </div>
                        </div>
                        <hr />
                        <div class="form-group">
                            <label>Program and Schedule completed?</label>
                            <select id="isScheduleCompleted" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].isScheduleCompleted : 0 %>">
                                <option value="0">No</option>
                                <option value="1">Yes</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Is the presentation completed with the client?</label>
                            <select id="isPresentationCompleted" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].isPresentationCompleted : 0 %>">
                                <option value="0">No</option>
                                <option value="1">Yes</option>
                            </select>
                        </div>
                        <% } %>
                        <hr />
                        <div class="form-group">
                            <label><%= Language.GetFixed("Durum") %> *</label>
                            <select id="Statu" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].Statu.ToString() : "1" %>" required>
                                <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 1))) { %>
                                <option value="<%= items.id %>" <%= RecordID > 0 && dList[0].Statu == items.id ? " selected" :  "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Not") %></label>
                            <textarea id="Message" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].Message : "" %></textarea>
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
    <script src="/raven/assets/js/tagify.js?v=<%= Utility.Feature.Version %>"></script>
    <script type="text/javascript">
        $("#CheckinDate").change(function () {
            let selectedDate = $(this).val();
            var newDate = new Date(selectedDate);
            newDate.setDate(newDate.getDate() + 2);
            newDate = newDate.toISOString().split('T')[0];
            $("#CheckoutDate").attr("min", selectedDate);
            $("#CheckoutDate").attr("max", newDate);
            $("#PresentationDate").attr("min", selectedDate);
            $("#PresentationDate").attr("max", newDate);
        });
    </script>
</asp:Content>