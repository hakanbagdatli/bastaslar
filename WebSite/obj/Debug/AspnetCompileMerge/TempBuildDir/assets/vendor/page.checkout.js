
$(document).ready(function () {
    let paymentStatu = GetQueryString("payment");
    if (paymentStatu == "false")
    {
        let refno = GetQueryString("ref");
        if (refno != null) {
            CheckPayment(refno);
        }
    }
});

/* check information */
$(".btn-create-reservation").on("click", function () {
    if ($("#AcceptPolicy")[0].checked) {
        let _car = GetQueryString("car");
        let _chekinPlace = GetQueryString("checkinplace");
        let _checkinDate = GetQueryString("checkindate");
        let _chekinTime = GetQueryString("checkintime");
        let _checkoutPlace = GetQueryString("checkoutplace");
        let _checkoutDate = GetQueryString("checkoutdate");
        let _checkoutTime = GetQueryString("checkouttime");
        let _description = $("#Description").val();
        let _name = $("#Name").val();
        let _surname = $("#Surname").val();
        let _birthday = $("#Birthday").val();
        let _nationality = $("#Nationality").val();
        let _phone = $("#Phone").val();
        let _email = $("#Email").val();
        //------------------------------------------
        if (_car != null && _chekinPlace != null && _checkinDate != null && _chekinTime != null && _checkoutDate != null && _checkoutTime != null && _name != "" && _surname != "" && _birthday != "" && _nationality != "" && _phone != "" && _email != "") {
            let OrderDetail = [{
                CarID: _car,
                Name: _name,
                Surname: _surname,
                Birthday: _birthday,
                Nationality: _nationality,
                Email: _email,
                Phone: _phone,
                CheckinPlace: _chekinPlace,
                CheckinDate: _checkinDate,
                CheckinTime: _chekinTime,
                CheckoutPlace: _checkoutPlace,
                CheckoutDate: _checkoutDate,
                CheckoutTime: _checkoutTime,
                Description: _description
            }];
            //------------------------------------------
            let paramaters = JSON.stringify({ value: OrderDetail });
            let data = postAjax("CreateReservation", paramaters);
            let dataItem = JSON.parse(data.d);
            //------------------------------------------
            if (dataItem.result == true) {
                let redirectURL = "/odeme-bilgileri?v=" + dataItem.items;
                window.location = redirectURL;
            }
            else
                alert(getLang(3), dataItem.message, "error");
        }
        //------------------------------------------
        else {
            $("input").each(function () {
                if ($(this).val() == "")
                    if ($(this).attr("required"))
                        $(this).addClass("border-red");
            });
            alert(getLang(2), getLang(4), "warning");
        }
    }
    else
        alert(getLang(2), getLang(12), "warning");
});

/* payment detail */
$(".btn-complete-payment").on("click", function () {
    let _PnrCode = GetQueryString("v");;
    let _CardHolder = $("#CardHolder").val();
    let _CardNumber = $("#CardNumber").val();
    let _CardExpiry = $("#CardExpiry").val();
    let _SecurityCode = $("#SecurityCode").val();
    //------------------------------------------
    if (_PnrCode != null && _CardHolder != "" && _CardNumber != "" && _CardExpiry != "" && _SecurityCode != "") {

        let CardDetail = [{
            PnrCode: _PnrCode,
            CardHolder: _CardHolder,
            CardNumber: _CardNumber,
            Month: _CardExpiry.split("/")[0],
            Year: _CardExpiry.split("/")[1],
            Cvc: _SecurityCode
        }];
        let paramaters = JSON.stringify({ value: CardDetail });
        let data = postAjax("PaymentDetail", paramaters);
        let dataItem = JSON.parse(data.d);
        //------------------------------------------
        if (dataItem.result == true) {
            swal({
                title: getLang(8),
                text: getLang(9),
                timer: 2000,
                button: {
                    visible: false,
                },
            }).then(function () {
                window.location = dataItem.message;
            }), 4000;
        }
        else
            alert(getLang(3), dataItem.message, "error");
    } else
        alert(getLang(2), getLang(4), "warning");
});

function CheckPayment(ReferenceNumber)
{
    let paramaters = JSON.stringify({ value: ReferenceNumber });
    let data = postAjax("PaymentStatu", paramaters);
    let dataItem = JSON.parse(data.d);
    //------------------------------------------
    if (dataItem.result == true) 
        alert(getLang(2), dataItem.message, "warning");
    else
        alert(getLang(3), dataItem.message, "error");
}