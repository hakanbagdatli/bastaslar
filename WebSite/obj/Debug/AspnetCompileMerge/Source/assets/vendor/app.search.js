var myCheckInDatePicker = "";
var myCheckOutDatePicker = "";
// Date Picker
$(document).ready(function () {
    GetDetail();
    if ($("#CheckinDate").length) {

        myCheckInDatePicker = MCDatepicker.create({
            el: '#CheckinDate',
            bodyType: 'modal',
            autoClose: true,
            closeOnBlur: true,
            firstWeekday: 1,
            minDate: new Date(),
            dateFormat: 'DD.MM.YYYY'

        });
        myCheckOutDatePicker = MCDatepicker.create({
            el: '#CheckoutDate',
            bodyType: 'modal',
            autoClose: true,
            closeOnBlur: true,
            firstWeekday: 1,
            minDate: new Date(),
            dateFormat: 'DD.MM.YYYY'
        });
    }
});

$("#DifferentLocation").on("click", function () {

    let dataValue = $(this).prop("checked");
    if (dataValue) {
        $(".pickup-location").find("label").text("Alış Yeri");
        $(".drop-location").removeClass("d-none");
    } else {
        $(".pickup-location").find("label").text("Alış / Dönüş Yeri");
        $(".drop-location").addClass("d-none");
    }
});

function GetDetail()
{
    $(".search-data").each(function ()
    {
        let dataID = $(this).attr("id").toLowerCase();
        let dataValue = GetQueryString(dataID);
        //------------------------------------------
        if (dataValue != null && dataValue != "" && dataValue != "0") {
            $(this).val(dataValue);
        }
    });
}


/* filtrele */
$(".btn-search-available-car").on("click", function () {

    let prefix = ".search-data";
    let filter = "";
    let canSend = true;
    $(prefix).each(function () {
        let dataID = $(this).attr("id");
        let dataValue = $(this).val();
        //------------------------------------------
        if (dataValue != null && dataValue != "" && dataValue != "0")
            filter += dataID.toLowerCase() + "=" + dataValue + "&";
        else {
            if ($(this).prop('required')) {
                canSend = false;
                alert(getLang(2), getLang(4), "warning");
            }
        }
    });
    if (canSend) {
        window.location = "/arac-listesi/?" + filter.slice(0, -1);
    }
});


/* rezervasyon */
$(".btn-reservation").on("click", function () {

    let prefix = ".search-data";
    let canSend = true;
    let newURL = "?car=" + $(this).data("id") + "&";
    $(prefix).each(function () {
        let dataID = $(this).attr("id");
        let dataValue = $(this).val();
        //------------------------------------------
        if (dataValue != null && dataValue != "" && dataValue != "0")
            newURL += dataID.toLowerCase() + "=" + dataValue + "&";
        else {
            if ($(this).prop('required')) {
                canSend = false;
                alert(getLang(2), getLang(4), "warning");
            }
        }
    });
    if (canSend) {
        window.location = "/rezervasyon" + newURL.slice(0, -1);
    }
});
