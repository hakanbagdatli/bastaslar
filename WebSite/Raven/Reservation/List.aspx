<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="WebSite.Raven.Reservation.Reservations" %>
<%@ Import Namespace="Utility" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="33" />
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
                                <a href="?dhx=add&catid=<%= CatID %>&type=<%= TurID %>" class="btn btn-primary font-weight-bold"><i class="la la-plus"></i>&nbsp;<%= Language.GetFixed("YeniKayit") %></a>
                                <a href="?type=<%=Request["type"] %>&dhx=all" class="btn btn-secondary font-weight-bold"><i class="la la-file-excel-o"></i>&nbsp;<%= Language.GetFixed("TumunuGor") %></a>
                                <a href="javascript:;" class="btn btn-save-list btn-secondary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("ListeGuncelle") %></a>
                                <% } else if (Request["dhx"] != "add") { %>
                                <a href="javascript:;" class="btn btn-save-data btn-primary font-weight-bold"><i class="la la-save"></i>&nbsp;<%= Language.GetFixed("Kaydet") %></a>
                                <% } %>
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                            </div>
                        </div>
                    </div>

                    <% if (Request["dhx"] == null)
                        { %>

                    <!-- body -->
                    <div class="card-body">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinResTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th style="min-width:120px;"><%= Language.GetFixed("TakipNo") %></th>
                                    <th style="min-width:200px;"><%= Language.GetFixed("AcentaAdi") %></th>
                                    <th style="min-width:120px;"><%= Language.GetFixed("Musteriler") %></th>
                                    <th style="min-width:200px;"><%= Language.GetFixed("Proje") %></th>
                                    <th style="min-width:200px;"><%= Language.GetFixed("Properties") %></th>
                                    <th style="min-width:120px;"><%= Language.GetFixed("AcentaKomisyon") %></th>
                                    <th style="min-width:120px;"><%= Language.GetFixed("SozlesmeFiyati") %></th>
                                    <% if (TurID == 0) { %>
                                    <th><%= Language.GetFixed("DepozitoOdendi") %></th>
                                    <th><%= Language.GetFixed("AnlasmaImzasi") %></th>
                                    <th><%= Language.GetFixed("HukukBurosuBilgi") %></th>
                                    <% } else if (TurID == 2) { %> 
                                    <th><%= Language.GetFixed("TaslakSozlesmeOnayi") %></th>
                                    <th><%= Language.GetFixed("AvukataGonder") %></th>
                                    <th><%= Language.GetFixed("Pesinat") %></th>
                                    <th><%= Language.GetFixed("MusteriImzaladi") %></th>
                                    <th><%= Language.GetFixed("YoneticiImzaladi") %></th>
                                    <th><%= Language.GetFixed("DamgaTarama") %></th>
                                    <% } else if (TurID == 1) { %>
                                    <th><%= Language.GetFixed("IslemBasladi") %></th>
                                    <th><%= Language.GetFixed("AcentaGonder") %></th>
                                    <th><%= Language.GetFixed("AcentaOnayi") %></th>
                                    <th><%= Language.GetFixed("FinansaGonder") %></th>
                                    <th><%= Language.GetFixed("KomisyonOdendi") %></th>
                                    <% } %>
                                    <th><%= Language.GetFixed("Durum") %></th>
                                    <th class="noExport"><%= Language.GetFixed("Islem") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    double TotalCommission = 0, TotalPrice = 0;
                                    List<Entities.Reservations> dList = Bll.Reservations.Select(0, filter: whereClause, sorting: " id DESC");
                                    foreach (var item in dList)
                                    {
                                        TotalCommission += Helper.MoneytoDouble(item.AgencyCommission);
                                        TotalPrice += Helper.MoneytoDouble(item.ContractPrice); %>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><a href="?dhx=edit&id=<%= item.id %>&type=<%= item.TurID %>"><%= item.TurID == 1 ? item.SaleNumber : item.ReservationNumber %></a></td>
                                        <td><%= item._AgencyName + " (" + item._SaleExecutive + ")"  %></td>
                                        <td><%= item._CustomerName + " " + item._CustomerSurname %></td>
                                        <td><%= item._ProjectName %></td>
                                        <td><%= item._PlanName %></td>
                                        <td><%= item.AgencyCommission %> £</td>
                                        <td><%= item.ContractPrice %> £</td>
                                        <% if (TurID == 0)
                                            { %>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckDep<%= item.id %>" name="isDepositPaid" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isDepositPaid) ? "checked" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckRes<%= item.id %>" name="isReservationApproved" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isReservationApproved) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isDepositPaid) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckLeg<%= item.id %>" name="hasLegalInfoProvided" type="checkbox" class="list-form-data"
                                                        <%= Convert.ToBoolean(item.hasLegalInfoProvided) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isReservationApproved) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <% } else if (TurID == 2) { %> 
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckDra<%= item.id %>" name="isDraftContractApproved" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isDraftContractApproved) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.hasLegalInfoProvided) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckLaw<%= item.id %>" name="isSendLawyer" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isSendLawyer) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isDraftContractApproved) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckDow<%= item.id %>" name="hasDownPayment" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.hasDownPayment) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isSendLawyer) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckCli<%= item.id %>" name="isClientApproved" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isClientApproved) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.hasDownPayment) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckDir<%= item.id %>" name="isDirectorApproved" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isDirectorApproved) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isClientApproved) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckSta<%= item.id %>" name="isStamped" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isStamped) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isDirectorApproved) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <% }
                                            else if (TurID == 1)
                                            { %>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckPro<%= item.id %>" name="isProcessStart" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isProcessStart) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isStamped) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckAge<%= item.id %>" name="isSendedAgent" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isSendedAgent) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isProcessStart) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckFin<%= item.id %>" name="isAgencyConfirmed" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isAgencyConfirmed) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isSendedAgent) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckAgeCom<%= item.id %>" name="isSendedFinance" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isSendedFinance) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isAgencyConfirmed) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="checkbox-list">
                                                <label class="checkbox">
                                                    <input id="ckCom<%= item.id %>" name="isCommissionPaid" type="checkbox" class="list-form-data" 
                                                        <%= Convert.ToBoolean(item.isCommissionPaid) ? "checked" : "" %>
                                                        <%= Convert.ToBoolean(item.isSendedFinance) == false ? "disabled" : "" %> />
                                                    <span></span>
                                                </label>
                                            </div>
                                        </td>
                                        <% } %>
                                        <td><span class="label label-lg label-light-<%= item._StatuColor %> label-inline"><%= item._Statu %></span></td>
                                        <td>
                                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                                <a href="<%= Developer.ConstantUrl("preview") + "?dhx=view&id=" + item.id  %>"  class="btn btn-outline-secondary font-weight-bold"><%= Language.GetFixed("Onizle") %></a>
                                                <div class="btn-group" role="group">
                                                    <button type="button" class="btn btn-secondary font-weight-bold dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <%= Language.GetFixed("Islem") %>
                                                    </button>
                                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop2">
                                                        <a href="?dhx=edit&id=<%= item.id %>&type=<%= item.TurID %>" class="dropdown-item"><%= Language.GetFixed("Duzenle") %></a>
                                                        <a href="<%= Developer.ConstantUrl("rfiles") + "?catid=" + item.id + "&type=" + item.TurID  %>" class="dropdown-item">Contracts</a>
                                                        <% if (item.TurID == 1) { %>
                                                        <a href="<%= Developer.ConstantUrl("rfeatures") + "?catid=" + item.id  + "&turid=0&type=" + item.TurID %>" class="dropdown-item">Selections</a>
                                                        <a href="<%= Developer.ConstantUrl("rfeatures") + "?catid=" + item.id + "&turid=1&type=" + item.TurID  %>" class="dropdown-item">Snagging</a>
                                                        <a href="<%= Developer.ConstantUrl("rfeatures") + "?catid=" + item.id + "&turid=2&type=" + item.TurID  %>" class="dropdown-item">Key Handover</a>
                                                        <% } %>
                                                        <a href="<%= Developer.ConstantUrl("rfeatures") + "?catid=" + item.id + "&turid=3&type=" + item.TurID  %>" class="dropdown-item">Checklist</a>
                                                        <a href="<%= Developer.ConstantUrl("sales") + "?catid=" + item.id + "&type=" + item.TurID  %>" class="dropdown-item">Payments</a>
                                                        <a href="javascript:;" onclick="Delete(<%= item.id %>)" class="dropdown-item"><%= Language.GetFixed("Sil") %></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                            <tfoot style="background: #f2f2f4;">
                                <tr>
                                    <td colspan="5"></td>
                                    <td><%= Language.GetFixed("ToplamKomisyon") %></td>
                                    <td><%= Utility.Helper.MoneyFormat(TotalCommission)  %></td>
                                    <td colspan="<%= TurID == 0 ? "6" : (TurID == 1 ? "2" : "9") %>"></td>
                                </tr>
                                <tr>
                                    <td colspan="5"></td>
                                    <td><%= Language.GetFixed("ToplamSozlesmeBedeli") %></td>
                                    <td></td>
                                    <td><%= Utility.Helper.MoneyFormat(TotalPrice) %></td>
                                    <td colspan="<%= TurID == 0 ? "5" : (TurID == 1 ? "1" : "8") %>"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    
                    <% } else if (Request["dhx"] == "all") { %>

                    <!-- body -->
                    <div class="card-body">
                        <table class="table table-separate table-head-custom table-checkable" id="liophinResTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th><%= Language.GetFixed("TakipNo") %></th>
                                    <th><%= Language.GetFixed("AcentaAdi") %></th>
                                    <th><%= Language.GetFixed("Musteriler") %></th>
                                    <th><%= Language.GetFixed("Proje") %></th>
                                    <th><%= Language.GetFixed("Properties") %></th>
                                    <th><%= Language.GetFixed("Gosterim") %></th>
                                    <th><%= Language.GetFixed("SummaryNo") %></th>
                                    <th><%= Language.GetFixed("RezervasyonTarih") %></th>
                                    <th><%= Language.GetFixed("ContractofSigning") %></th>
                                    <th><%= Language.GetFixed("ListeFiyati") %></th>
                                    <th><%= Language.GetFixed("BastaslarIndirim") %></th>
                                    <th><%= Language.GetFixed("YeniSatisFiyati") %></th>
                                    <th><%= Language.GetFixed("AcentaIndirimi") %></th>
                                    <th><%= Language.GetFixed("AcentaKomisyon") %></th>
                                    <th><%= Language.GetFixed("SozlesmeFiyati") %></th>
                                    <th><%= Language.GetFixed("DepozitoOdendi") %></th>
                                    <th><%= Language.GetFixed("AnlasmaImzasi") %></th>
                                    <th><%= Language.GetFixed("HukukBurosuBilgi") %></th>
                                    <th><%= Language.GetFixed("TaslakSozlesmeOnayi") %></th>
                                    <th><%= Language.GetFixed("AvukataGonder") %></th>
                                    <th><%= Language.GetFixed("Pesinat") %></th>
                                    <th><%= Language.GetFixed("MusteriImzaladi") %></th>
                                    <th><%= Language.GetFixed("YoneticiImzaladi") %></th>
                                    <th><%= Language.GetFixed("DamgaTarama") %></th>
                                    <th><%= Language.GetFixed("IslemBasladi") %></th>
                                    <th><%= Language.GetFixed("AcentaGonder") %></th>
                                    <th><%= Language.GetFixed("AcentaOnayi") %></th>
                                    <th><%= Language.GetFixed("FinansaGonder") %></th>
                                    <th><%= Language.GetFixed("KomisyonOdendi") %></th>
                                    <th><%= Language.GetFixed("Durum") %></th>
                                    <th><%= Language.GetFixed("KisaIcerik") %></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    List<Entities.Reservations> dListAll = Bll.Reservations.Select(0, filter: whereClause, sorting: " id DESC");
                                    foreach (var item in dListAll) {%>
                                    <tr class="list-data" data-id="<%= item.id %>">
                                        <td><%= item.id  %></td>
                                        <td><a href="?dhx=edit&id=<%= item.id %>&type=<%= item.TurID %>"><%= item.TurID == 1 ? item.SaleNumber : item.ReservationNumber %></a></td>
                                        <td><%= item._AgencyName + " (" + item._SaleExecutive + ")"  %></td>
                                        <td><%= item._CustomerName + " " + item._CustomerSurname %></td>
                                        <td><%= item._ProjectName %></td>
                                        <td><%= item._PlanName %></td>
                                        <td><%= item._InspectionNumber %></td>
                                        <td><%= item.SummaryNumber %></td>
                                        <td><%= item.ReservationDate %></td>
                                        <td><%= item.ContractofSigning %></td>
                                        <td><%= item.ListPrice %> £</td>
                                        <td><%= item.Discount %> £</td>
                                        <td><%= item.SalePrice %> £</td>
                                        <td><%= item.AgencyDiscount %> £</td>
                                        <td><%= item.AgencyCommission %> £</td>
                                        <td><%= item.ContractPrice %> £</td>
                                        <td><%= Convert.ToBoolean(item.isDepositPaid) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isReservationApproved) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.hasLegalInfoProvided) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isDraftContractApproved) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isSendLawyer) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.hasDownPayment) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isClientApproved) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isDirectorApproved) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isStamped) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isProcessStart) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isSendedAgent) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isAgencyConfirmed) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isSendedFinance) ? "Yes" : "No" %></td>
                                        <td><%= Convert.ToBoolean(item.isCommissionPaid) ? "Yes" : "No" %></td>
                                        <td><span class="label label-lg label-light-<%= item._StatuColor %> label-inline"><%= item._Statu %></span></td>
                                        <td><%= item.ShortContent %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } else { %>

                    <!-- body -->
                    <div class="card-body">
                        <input id="id" class="form-control form-data" type="hidden" value="<%= RecordID %>" />
                        <% List<Entities.Reservations> dList = Bll.Reservations.Select(RecordID, filter: ""); %>
                        <input id="SaleNumber" class="form-control form-data" type="hidden" value="<%= RecordID > 0 ? dList[0].SaleNumber : Function.GeneratePNR("SAL") %>" />
                        <input id="ReservationNumber" class="form-control form-data" type="hidden" value="<%= RecordID > 0 ? dList[0].ReservationNumber : Function.GeneratePNR("RES") %>" />
                        <div class="form-group">
                            <label><%= Language.GetFixed("AcentaAdi") %></label>
                            <div class="input-group">
                                <select id="AgencyID" class="form-control form-data form-data-option selectpicker" data-live-search="true" onchange="SelectedChange('AgencyID','GetCustomers','CustomerID')" data-value="<%= RecordID > 0 ? dList[0].AgencyID.ToString() : "0" %>">
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
                        <div class="form-group">
                            <label><%= Language.GetFixed("KayitTuru") %></label>
                            <select id="TurID" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].TurID.ToString() : TurID.ToString() %>">
                                <option value="0">Reservation</option>
                                <option value="2">In Process</option>
                                <option value="1">Completed Sales</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Inspection/PropertyNo") %></label>
                            <select id="InspectionNumber" class="form-control form-data form-data-option selectpicker" data-live-search="true" data-value="<%= RecordID > 0 ? dList[0].InspectionNumber.ToString() : "" %>">
                                <% List<Entities.Inspections> inspectList = Bll.Inspections.Select(0, filter: " AND Approved=1");
                                    foreach (var items in inspectList) { %>
                                        <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].InspectionNumber == items.PNRCode ? " selected" : "" : "" %>><%= items.PNRCode + " - " + string.Join(", ", items._Projects.Select(project => project.Title)) %> </option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("VarsaSummaryNo") %></label>
                            <input id="SummaryNumber" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].SummaryNumber : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("IlgiliProje") %></label>
                            <div class="input-group">
                                <select id="ProjectID" class="form-control form-data form-data-option" onchange="SelectedChange('ProjectID','GetPlans','PlanID')" data-value="<%= RecordID > 0 ? dList[0].ProjectID.ToString() : "0" %>">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                    <% var _idList = Select.MultipleCategoryID(3).Split(',').Select(int.Parse).ToList();
                                        List<Entities.GeneralRecords> projectList = Entities.StaticList.Records.Where(x => (_idList.Contains(x.CatID)) && (x.Approved == 1)).ToList();
                                        foreach (var items in projectList) { %>
                                        <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].ProjectID == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                    <% } %>
                                </select>
                                <div class="input-group-append">
									<a href="<%= Developer.ConstantUrl("content") %>?catid=3&ptype=15" target="_blank" class="btn btn-secondary">
                                        <i class="la la-plus-circle"></i>
									</a>
								</div>
							</div>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("DaireBilgisi") %></label>
                            <select id="PlanID" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].PlanID.ToString() : "0" %>" onchange="SelectedChangetoInput('PlanID','GetListPrice','ListPrice')">
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("MusteriBilgi") %></label>
                            <div class="input-group">
                                <select id="CustomerID" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].CustomerID.ToString() : "0" %>">
                                    <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                </select>
                                <div class="input-group-append">
									<a href="<%= Developer.ConstantUrl("customers") %>?dhx=add" target="_blank" class="btn btn-secondary">
                                        <i class="la la-plus-circle"></i>
									</a>
								</div>
							</div>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("KisaIcerik") %></label>
                            <textarea id="ShortContent" class="form-control form-data" rows="4"><%= RecordID > 0 ? dList[0].ShortContent : "" %></textarea>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("RezervasyonTarih") %></label>
                            <input id="ReservationDate" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].ReservationDate : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("SozlesmeTarihi") %></label>
                            <input id="ContractofSigning" class="form-control form-data" type="date" value="<%= RecordID > 0 ? dList[0].ContractofSigning : "" %>" />
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("ListeFiyati") %></label>
                            <div class="input-group">
								<div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="ListPrice" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].ListPrice : "0" %>" disabled />
							</div>
                            <small><%= Language.GetFixed("FiyatAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("BastaslarIndirim") %></label>
                            <div class="input-group">
								<div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="Discount" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].Discount : "0" %>" />
							</div>
                            <small><%= Language.GetFixed("FiyatAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("YeniSatisFiyati") %></label>
                            <div class="input-group">
								<div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="SalePrice" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].SalePrice : "0" %>" />
							</div>
                            <small><%= Language.GetFixed("FiyatAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("AcentaIndirimi") %></label>
                            <div class="input-group">
								<div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="AgencyDiscount" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].AgencyDiscount : "0" %>" />
							</div>
                            <small><%= Language.GetFixed("FiyatAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("AcentaKomisyon") %></label>
                            <div class="input-group">
								<div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="AgencyCommission" class="form-control form-data" type="text" value="<%= RecordID > 0 ? dList[0].AgencyCommission : "0" %>" />
							</div>
                            <small><%= Language.GetFixed("FiyatAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("SozlesmeFiyati") %></label>
                            <div class="input-group">
								<div class="input-group-prepend"><span class="input-group-text">GBP</span></div>
                                <input id="ContractPrice" class="form-control form-data money" type="text" value="<%= RecordID > 0 ? dList[0].ContractPrice : "0" %>" />
							</div>
                            <small><%= Language.GetFixed("FiyatAciklama") %></small>
                        </div>
                        <div class="form-group">
                            <label><%= Language.GetFixed("Durum") %></label>
                            <select id="Statu" class="form-control form-data form-data-option" data-value="<%= RecordID > 0 ? dList[0].Statu.ToString() : "0" %>">
                                <option value="0"><%= Language.GetFixed("LutfenSec") %></option>
                                <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 1))) { %>
                                    <option value="<%= items.id %>" <%= RecordID > 0 ? dList[0].Statu == items.id ? " selected" : "" : "" %>><%= items.Title %></option>
                                <% } %>
                            </select>
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
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server"></asp:Content>