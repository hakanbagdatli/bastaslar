<%@ Page Title="" Language="C#" MasterPageFile="~/Partner/Page.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="WebSite.Partner.Projects" %>
<%@ Import Namespace="Tools" %>
<%@ Import Namespace="Utility" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/raven/assets/css/custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">
    <div class="container-fluid" style="padding:0 5%">
        <div class="row">
            <div class="col-md-12">

                <!-- header -->
                <div class="card card-custom gutter-b example example-compact">
                    <div class="card-header flex-wrap py-3">
                        <div class="card-title">
                            <div class="d-block text-muted pt-2 font-size-sm">
                                <ul class="breadcrumb breadcrumb-transparent breadcrumb-dot font-weight-bold p-0 my-2 font-size-sm">
                                    <li class="breadcrumb-item"><a href="/partner/" class="text-muted"><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item"><a href="javascript:;" class="text-muted"><%= Language.GetPartner("ProjectList") %></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-toolbar">
                            <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                                <% if (Request["dhx"] != null && UserData.id > 0) {  %>
                                <a href="javascript:;" class="btn btn-export-pdf btn-primary font-weight-bold" data-id="<%= Request["id"].ToString() %>" data-lang="<%= PLanguage %>">
                                    <i class="la la-file-pdf"></i>&nbsp;<%= Language.GetPartner("PdfIndir") %></a>
                                <% } %>
                                <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetPartner("GeriDon") %></a>
                            </div>
                        </div>
                    </div>
                </div>

                <% if (Request["dhx"] == null) { %>

                <!-- list -->
                
                <% foreach (var cat in Bll.GeneralCategories.Select(0, filter: " AND CatID=3 AND Approved=1", sorting: " Sorting ASC, id ASC", lang: PLanguage)) { %>
                <div class="card-header bg-transparent pl-0">
                    <h2><%= cat.Title %></h2>
                </div>
                <div class="row">
                    <% foreach (var item in Bll.GeneralRecords.Select(0, filter: " AND CatID=" + cat.id +" AND Approved=1", sorting: " Sorting ASC, id DESC", lang: PLanguage)) { %>
                    <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6">
                        <div class="card card-custom gutter-b card-stretch">
                            <div class="card-body pt-4">
                                <div class="d-flex align-items-center mb-7">
                                    <div class="flex-shrink-0 mr-4">
                                        <div class="symbol symbol-circle symbol-lg-75">
                                            <% List<Entities.GeneralPhotos> photoList = Bll.GeneralPhotos.Select(0, filter: " AND TypeID=0 AND CatID=" + item.id + " AND Approved=1", sorting: " Sorting ASC, id ASC", rowCount: 1);
                                                foreach (var pho in photoList) { %>
                                            <img src="<%= Feature.ImageFolder + pho.Image %>" alt="<%= pho.Title %>" />
                                            <% } %>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-column">
                                        <a href="?dhx=detail&id=<%= item.id + "&catid=" + item.CatID %>" class="text-dark font-weight-bold text-hover-primary font-size-h4 mb-0">
                                            <%= Handler.SetPartnerText(item.Title, item._Title) %></a>
                                        <span class="label label-inline label-lg label-light-<%= item._PropertyStatuColor %> btn-sm font-weight-bold"><%= item._PropertyStatu %></span>
                                    </div>
                                </div>
                                <p class="mb-7"><%= Handler.SetPartnerText(item.ShortContent, item._ShortContent) %></p>
                                <div class="mb-7">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-dark-75 font-weight-bolder mr-2"><%= Language.GetPartner("VillaSayisi") %></span>
                                        <span class="text-muted font-weight-bold"><%= item.PropertyVillaCount %></span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center my-1">
                                        <span class="text-dark-75 font-weight-bolder mr-2"><%= Language.GetPartner("DaireSayisi") %></span>
                                        <a href="#" class="text-muted text-hover-primary"><%= item.PropertyFlatCount %></a>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center my-1">
                                        <span class="text-dark-75 font-weight-bolder mr-2"><%= Language.GetPartner("BaslangicTarih") %></span>
                                        <span class="text-muted font-weight-bold"><%= item.PropertyStartDate %></span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-dark-75 font-weight-bolder mr-2"><%= Language.GetPartner("BitisTarih") %></span>
                                        <a href="#" class="text-muted text-hover-primary"><%= item.PropertyEndDate %></a>
                                    </div>
                                </div>
                                <a href="?dhx=detail&id=<%= item.id + "&catid=" + item.CatID %>" class="btn btn-block btn-sm btn-light-success font-weight-bolder text-uppercase py-4">
                                    <%= Language.GetPartner("DetayliBilgi") %></a>
                            </div>
                        </div>
                    </div>
                    <% }  %>  
                </div>
                <% } %>

                <% } else { %>


                <div class="card card-custom gutter-b">
					<div class="card-body">
                        
                    <% List<Entities.GeneralRecords> dataList = Bll.GeneralRecords.Select(Convert.ToInt32(Request["id"].ToString()), filter: "", lang: PLanguage);
                        foreach (var item in dataList) { %>
						<div class="d-flex">
							<div class="flex-shrink-0 mr-7 mt-lg-0 mt-3">
								<div class="symbol symbol-50 symbol-lg-120">
                                    <% foreach (var pho in Bll.GeneralPhotos.Select(0, filter: " AND TypeID=0 AND CatID=" + item.id + " AND Approved=1", sorting: " Sorting ASC, id ASC", rowCount: 1)) { %>
                                    <img src="<%= Feature.ImageFolder + pho.Image %>" alt="<%= pho.Title %>" />
                                    <% } %>
								</div>
							</div>
							<div class="flex-grow-1">
								<div class="d-flex align-items-center justify-content-between flex-wrap">
									<div class="mr-3">
										<a href="#" class="d-flex align-items-center text-dark text-hover-primary font-size-h5 font-weight-bold mr-3"><%= Handler.SetPartnerText(item.Title, item._Title) %>
										<i class="flaticon2-correct text-success icon-md ml-2"></i></a>
										<div class="d-flex flex-wrap my-2">
											<a href="#" class="text-muted text-hover-primary font-weight-bold">
											    <span class="svg-icon svg-icon-md svg-icon-gray-500 mr-1">
												    <!--begin::Svg Icon | path:assets/media/svg/icons/Map/Marker2.svg-->
												    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
													    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
														    <rect x="0" y="0" width="24" height="24"></rect>
														    <path d="M9.82829464,16.6565893 C7.02541569,15.7427556 5,13.1079084 5,10 C5,6.13400675 8.13400675,3 12,3 C15.8659932,3 19,6.13400675 19,10 C19,13.1079084 16.9745843,15.7427556 14.1717054,16.6565893 L12,21 L9.82829464,16.6565893 Z M12,12 C13.1045695,12 14,11.1045695 14,10 C14,8.8954305 13.1045695,8 12,8 C10.8954305,8 10,8.8954305 10,10 C10,11.1045695 10.8954305,12 12,12 Z" fill="#000000"></path>
													    </g>
												    </svg>
											    </span>
                                                <%= item._CategoryName %>
											</a>
										</div>
									</div>
								</div>
								<div class="d-flex align-items-center flex-wrap justify-content-between">
									<div class="flex-grow-1 font-weight-bold text-dark-50 py-5 py-lg-2 mr-5" style="max-width:55%;"><%= Handler.SetPartnerText(item.MainContent, item._MainContent) %></div>
									<div class="d-flex flex-wrap align-items-center py-2">
										<div class="d-flex align-items-center mr-10">
											<div class="mr-6">
												<div class="font-weight-bold mb-2"><%= Language.GetPartner("BaslangicTarih")  %></div>
												<span class="btn btn-sm btn-text btn-light-primary text-uppercase font-weight-bold"><%= Helper.DatewithCulture(item.PropertyStartDate, PLanguage) %></span>
											</div>
											<div class="">
												<div class="font-weight-bold mb-2"><%= Language.GetPartner("BitisTarih") %></div>
												<span class="btn btn-sm btn-text btn-light-danger text-uppercase font-weight-bold"><%= Helper.DatewithCulture(item.PropertyEndDate, PLanguage) %></span>
											</div>
										</div>
										<div class="flex-grow-1 flex-shrink-0 w-150px w-xl-300px mt-4 mt-sm-0">
											<span class="font-weight-bold"><%= Language.GetPartner("Surec") %></span>
                                            <% int progress = CalculateProgressPercentage(item.PropertyStartDate, item.PropertyEndDate); %>
											<div class="progress progress-xs mt-2 mb-2">
												<div class="progress-bar bg-<%= progress < 60 ? "warning" : "success" %>" role="progressbar" style="width: <%= progress %>%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
											</div>
											<span class="font-weight-bolder text-dark"><%= progress %>%</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="separator separator-solid my-7"></div>
						<div class="d-flex align-items-center flex-wrap">
							<div class="d-flex align-items-center flex-lg-fill mr-5 my-1">
								<span class="mr-4">
									<i class="flaticon-time-2 icon-2x text-muted font-weight-bold"></i>
								</span>
								<div class="d-flex flex-column text-dark-75">
									<span class="font-weight-bolder font-size-sm"><%= Language.GetPartner("ProjeDurum") %></span>
									<span class="font-weight-bolder font-size-h5"><%= item._PropertyStatu %></span>
								</div>
							</div>
							<div class="d-flex align-items-center flex-lg-fill mr-5 my-1">
								<span class="mr-4">
									<i class="flaticon-buildings icon-2x text-muted font-weight-bold"></i>
								</span>
								<div class="d-flex flex-column text-dark-75">
									<span class="font-weight-bolder font-size-sm"><%= Language.GetPartner("VillaSayisi") %></span>
									<span class="font-weight-bolder font-size-h5"><%= item.PropertyVillaCount %></span>
								</div>
							</div>
							<div class="d-flex align-items-center flex-lg-fill mr-5 my-1">
								<span class="mr-4">
									<i class="flaticon-home icon-2x text-muted font-weight-bold"></i>
								</span>
								<div class="d-flex flex-column text-dark-75">
									<span class="font-weight-bolder font-size-sm"><%= Language.GetPartner("DaireSayisi") %></span>
									<span class="font-weight-bolder font-size-h5"><%= item.PropertyFlatCount %></span>
								</div>
							</div>
							<div class="d-flex align-items-center flex-lg-fill mr-5 my-1">
								<span class="mr-4">
									<i class="flaticon-pie-chart icon-2x text-muted font-weight-bold"></i>
								</span>
								<div class="d-flex flex-column text-dark-75">
									<span class="font-weight-bolder font-size-sm">m² (Net)</span>
									<span class="font-weight-bolder font-size-h5"><%= item.PropertySize %></span>
								</div>
							</div>
						</div>
                        <% } %>
					</div>
				</div>

                <div class="accordion accordion-solid accordion-panel accordion-svg-toggle" id="accordionExample">
                    
                    <!-- payment -->
                    <div class="card">
                        <div class="card-header" id="headingEight">
                            <div class="card-title collapsed" data-toggle="collapse" data-target="#collapseEight">
                                <div class="card-label"><%= Language.GetPartner("OdemePlani") %></div>
                            </div>
                        </div>
                        <div id="collapseEight" class="collapse" data-parent="#accordionExample">
                            <div class="card-body">
                                <div class="row">
                                    <% foreach (var item in dataList) { %>
                                    <div class="col-lg-3 mb-3">
                                        <span class="font-size-h4 font-weight-bolder text-white text-hover-primary">
                                            <%= item.PropertyPaymentPlan %>
                                        </span>
                                    </div>
                                    <% }  %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- images -->
                    <div class="card">
                        <div class="card-header" id="headingTwo">
                            <div class="card-title collapsed" data-toggle="collapse" data-target="#collapseTwo">
                                <div class="card-label"><%= Language.GetPartner("ProjeGorselleri") %></div>
                            </div>
                        </div>
                        <div id="collapseTwo" class="collapse" data-parent="#accordionExample">
                            <div class="card-body">
                                <div class="row">
                                    <% List<Entities.GeneralPhotos> photoList = Bll.GeneralPhotos.Select(0, filter: " AND CatID in (" + Request["id"].ToString() + ")", sorting: " Sorting ASC, id ASC");
                                        foreach (var item in photoList.Where(x => (x.TypeID == 0))) { %>
                                    <div class="col-lg-3 mb-3">
                                        <a href="<%= Feature.ImageFolder + item.Image %>" class="card card-custom overlay" data-fancybox="images">
                                            <div class="card-body p-0">
                                                <div class="overlay-wrapper">
                                                    <img src="<%= Feature.ImageFolder + item.Image %>" class="w-100 rounded" />
                                                </div>
                                                <div class="overlay-layer m-5 rounded align-items-end justify-content-start">
                                                    <div class="d-flex flex-column align-items-start mb-5 ml-5">
                                                        <span class="font-size-h4 font-weight-bolder text-white text-hover-primary"><%= item.Title %></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <% }  %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- videos -->
                    <div class="card">
                        <div class="card-header" id="headingThree">
                            <div class="card-title collapsed" data-toggle="collapse" data-target="#collapseThree">
                                <div class="card-label"><%= Language.GetPartner("ProjeVideolari") %></div>
                            </div>
                        </div>
                        <div id="collapseThree" class="collapse" data-parent="#accordionExample">
                            <div class="card-body">
                                <div class="row">
                                    <% List<Entities.GeneralVideos> videoList = Bll.GeneralVideos.Select(0, filter: " AND CatID in (" + Request["id"].ToString() + ")", sorting: " Sorting ASC, id ASC");
                                        foreach (var item in videoList.Where(x => (x.TypeID == 0))) { %>
                                    <div class="col-lg-3 mb-5">
                                        <a href="<%= !String.IsNullOrEmpty(item.VideoUrl) ? Feature.VideoFolder + item.VideoUrl : item.VideoEmbed %>" class="card card-custom overlay" target="_blank">
                                            <div class="card-body p-0">
                                                <div class="overlay-wrapper">
                                                    <img src="<%= Feature.ImageFolder + item.Image %>" class="w-100 rounded" />
                                                </div>
                                                <div class="overlay-layer m-5 rounded align-items-end justify-content-start">
                                                    <div class="d-flex flex-column align-items-start mb-5 ml-5">
                                                        <span class="font-size-h4 font-weight-bolder text-white text-hover-primary"><%= item.Title %></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <% }  %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- files -->
                    <div class="card">
                        <div class="card-header" id="headingFour">
                            <div class="card-title collapsed" data-toggle="collapse" data-target="#collapseFour">
                                <div class="card-label"><%= Language.GetPartner("TeknikKatPlanlari") %></div>
                            </div>
                        </div>
                        <div id="collapseFour" class="collapse" data-parent="#accordionExample">
                            <div class="card-body pt-5">
                                <div class="row">
                                    <div class="file-wrap">
                                        <ul class="list-wrap">
                                            <% List<Entities.GeneralFiles> fileList = Bll.GeneralFiles.Select(0, filter: " AND CatID in (" + Request["id"].ToString() + ")", sorting: " Sorting ASC, Title ASC");
                                                foreach (var item in fileList) { %>
                                            <li>
                                                <a href="<%= Feature.FileFolder + item.Filename %>" title="<%= item.Title %>" target="_blank">
                                                    <img src="/raven/assets/media/files/<%= item.FileTypeID %>.svg" alt="<%= item.Title %>" />
                                                    <span><%= item.Title %></span>
                                                </a>
                                            </li>
                                            <% }  %>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- properties -->
                    <div class="card">
                        <div class="card-header" id="headingFive">
                            <div class="card-title" data-toggle="collapse" data-target="#collapseFive">
                                <div class="card-label"><%= Language.GetPartner("Properties") %></div>
                            </div>
                        </div>
                        <div id="collapseFive" class="collapse show" data-parent="#accordionExample">
                            <div id="TableArea" class="card-body p-10">
                                <table class="table table-separate table-head-custom table-checkable" id="propertiesTable">
                                    <thead>
                                        <tr>
                                            <th><%= Language.GetPartner("Baslik") %></th>
                                            <th><%= Language.GetPartner("Kat") %></th>
                                            <th><%= Language.GetPartner("KapaliBrut") %> (m²)</th>
                                            <th><%= Language.GetPartner("KapaliTeras") %> (m²)</th>
                                            <th><%= Language.GetPartner("ToplamBrut") %> (m²)</th>
                                            <th><%= Language.GetPartner("AcikTeras") %> (m²)</th>
                                            <th><%= Language.GetPartner("CatiTerasi") %> (m²)</th>
                                            <th><%= Language.GetPartner("GarajAlani") %> (m²)</th>
                                            <th><%= Language.GetPartner("HavuzAlani") %> (m²)</th>
                                            <th><%= Language.GetPartner("Arazi") %> (m²)</th>
                                            <th><%= Language.GetPartner("ListeFiyati") %></th>
                                            <th><%= Language.GetPartner("YatakOdasi") %></th>
                                            <th><%= Language.GetPartner("Durum") %></th>
                                            <th class="noExport"><%= Language.GetPartner("Islem") %></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<Entities.GeneralPlans> planList = Bll.GeneralPlans.Select(0, filter: " AND PropertyStatus in ('reserved','available') AND CatID in (" + Request["id"].ToString() + ")", sorting: " Sorting ASC, id ASC");
                                            foreach (var item in planList) { %>
                                            <tr class="list-data" data-id="<%= item.id %>">
                                                <td><%= item.Title  %></td>
                                                <td><%= item.PropertyFloor  %></td>
                                                <td><%= item.PropertyGrossArea %> m<sup>2</sup></td>
                                                <td><%= item.PropertyTerraceArea %> m<sup>2</sup></td>
                                                <td><%= item.PropertySize %> m<sup>2</sup></td>
                                                <td><%= item.PropertyOpenTerrace %> m<sup>2</sup></td>
                                                <td><%= item.PropertyRoofTerrace %> m<sup>2</sup></td>
                                                <td><%= item.PropertyGarageArea %> m<sup>2</sup></td>
                                                <td><%= item.PropertyPoolArea %> m<sup>2</sup></td>
                                                <td><%= item.PropertyLandArea %> m<sup>2</sup></td>
                                                <td><%= item.PropertyPrice %> £</td>
                                                <td><%= item.PropertyBedroom %></td>
                                                <td><%= Function.PropertyStatuBadge(item.PropertyStatus)  %></td>
                                                <td class="noExport">
                                                    <div class="btn-group" role="group">
                                                        <a href="<%= Feature.FileFolder + (PLanguage == "2" ? item.Filename : item.FilenameTR) %>" target="_blank" class="btn btn-outline-secondary font-weight-bold">
                                                            <%= Language.GetPartner("Dosya") %></a>
                                                        <a href="<%= item.VideoEmbed %>" target="_blank" class="btn btn-outline-secondary font-weight-bold"><%= Language.GetPartner("Video") %></a>
                                                    </div>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- social-media -->
                    <div class="card">
                        <a href="<%=dataList[0].PropertySocialMedia %>" target="_blank" class="card-header" id="headingSix">
                            <div class="card-title collapsed" data-toggle="collapse" data-target="#collapseSix">
                                <div class="card-label"><%= Language.GetPartner("SosyalMedya") %></div>
                            </div>
                        </a>
                    </div>
                    
                    <!-- availibilityList -->
                    <div class="card">
                        <div class="card-header" id="headingSeven">
                            <div class="card-title" data-toggle="collapse" data-target="#collapseSeven">
                                <div class="card-label"><%= Language.GetPartner("MulkMusaitlikleri") %></div>
                            </div>
                        </div>
                        <div id="collapseSeven" class="collapse show" data-parent="#accordionExample">
                            <div id="AvailibilityArea" class="card-body p-10">
                                <% foreach (var item in dataList) { %>
                                <a href="<%= item.PropertyVirtualTour %>" title="Show on Site" target="_blank" class="btn btn-secondary font-weight-bold mb-4"><%= Language.GetPartner("YeniSekmeAc") %></a>
                                <iframe src="<%= item.PropertyVirtualTour %>" width="100%" height="800"></iframe>
                                <% } %>
                            </div>
                        </div>
                    </div>

                </div>

                <% } %>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    <script src="/raven/assets/vendors/page.projects.js?v=<%= Feature.Version %>"></script>
</asp:Content>