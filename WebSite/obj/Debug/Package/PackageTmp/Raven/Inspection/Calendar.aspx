<%@ Page Title="" Language="C#" MasterPageFile="~/Raven/Page.Master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="WebSite.Raven.Inspection.Calendar" %>
<%@ Import Namespace="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/raven/assets/css/fullcalendar.bundle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pagecontent" runat="server">

    <input id="table" class="form-control" type="hidden" value="26" />
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
                                    <div class="dropdown">
                                        <button class="btn btn-filter-room btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Filter by Meeting Room
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a href="javascript:;" class="dropdown-item" data-id="all">All Rooms</a>
                                            <% foreach (var items in Entities.StaticList.Defines.Where(x => (x.CatID == 5))) { %>
                                            <a href="javascript:;" class="dropdown-item" data-id="<%= items.id %>" ><%= items.Title %></a>
                                            <% } %>
                                        </div>
                                    </div>
                                    <a href="javascript:;" onclick="window.history.back()" class="btn btn-secondary font-weight-bold"><i class="la la-mail-reply"></i>&nbsp;<%= Language.GetFixed("GeriDon") %></a>
                                </div>
                            </div>
                        </div>

                        <!-- body -->
                        <div class="card-body">
                            <div id="kt_calendar" style="max-width:100%;"></div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="Server">
    <script src="/raven/assets/js/fullcalendar.bundle.js"></script>
    <script type="text/javascript">
        "use strict";

        var KTCalendarListView = function () {

            return {
                //main function to initiate the module
                init: function () {
                    var todayDate = moment().startOf('day');
                    var YM = todayDate.format('YYYY-MM');
                    var YESTERDAY = todayDate.clone().subtract(1, 'day').format('YYYY-MM-DD');
                    var TODAY = todayDate.format('YYYY-MM-DD');
                    var TOMORROW = todayDate.clone().add(1, 'day').format('YYYY-MM-DD');

                    var calendarEl = document.getElementById('kt_calendar');
                    var calendar = new FullCalendar.Calendar(calendarEl, {
                        plugins: ['interaction', 'dayGrid', 'timeGrid', 'list'],
                        isRTL: KTUtil.isRTL(),
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                        },
                        height: 800,
                        contentHeight: 750,
                        aspectRatio: 3,  // see: https://fullcalendar.io/docs/aspectRatio
                        views: {
                            dayGridMonth: { buttonText: 'month' },
                            timeGridWeek: { buttonText: 'week' },
                            timeGridDay: { buttonText: 'day' },
                            listDay: { buttonText: 'list' },
                            listWeek: { buttonText: 'list' }
                        },

                        defaultView: 'dayGridMonth',
                        defaultDate: TODAY,
                        html: true,
                        editable: true,
                        eventLimit: true, // allow "more" link when too many events
                        navLinks: true,
                        events: [<%= GetJSONData %>],
                    eventRender: function (info) {
                        var element = $(info.el);

                        if (info.event.extendedProps && info.event.extendedProps.description) {
                            var descriptionHTML = info.event.extendedProps.description;

                            if (element.hasClass('fc-day-grid-event')) {
                                element.data('content', descriptionHTML);
                                element.data('placement', 'top');
                                element.popover({
                                    html: true, // HTML içeriği etkinleştirildi
                                    trigger: 'hover' // Üzerine gelindiğinde açılması için ayar
                                });
                                KTApp.initPopover(element);
                            } else if (element.hasClass('fc-time-grid-event')) {
                                element.find('.fc-title').append('<div class="fc-description">' + descriptionHTML + '</div>');
                            } else if (element.find('.fc-list-item-title').length !== 0) {
                                element.find('.fc-list-item-title').append('<div class="fc-description">' + descriptionHTML + '</div>');
                            }
                        }
                    }

                });

                    calendar.render();

                    document.querySelectorAll('.dropdown-item').forEach(function (item) {
                        item.addEventListener('click', function () {
                            var selectedRoomId = this.getAttribute('data-id');
                            $(".btn-filter-room").text(this.textContent);
                            calendar.getEvents().forEach(function (event) {
                                if (selectedRoomId === "all")
                                    event.setProp('classNames', []);
                                else if (event.extendedProps.room === selectedRoomId)
                                    event.setProp('classNames', []);
                                else
                                    event.setProp('classNames', ['d-none']);
                            });
                        });
                    });





                }
            };
        }();

        jQuery(document).ready(function () {
            KTCalendarListView.init();
        });

    </script>
</asp:Content>