/* kullanıcı bilgilerini getirme */
$(document).ready(function () {
    let data = postAjax("UserInformation", "");
    let dataItem = JSON.parse(data.d);
    //------------------------------------------
    if (dataItem.result)
    {
        $("#Name").val(dataItem.items[0].Name);
        $("#Surname").val(dataItem.items[0].Surname);
        $("#Email").val(dataItem.items[0].Email);
        $("#Phone").val(dataItem.items[0].Phone);
        $("#Birthday").val(dataItem.items[0].Birthday);
        $("#Gender").val(dataItem.items[0].Gender);
    }
    else
        alert(getLang(3), dataItem.message, "error");
});

/* kullanıcı bilgilerini güncelleme */
$(".btn-update-profile").on('click', function () {
    let name = $("#Name").val();
    let surname = $("#Surname").val();
    let email = $("#Email").val();
    let phone = $("#Phone").val();
    let birthday = $("#Birthday").val();
    let gender = $("#Gender").val();
    //------------------------------------------
    if (email != "" && name != "" && surname != "")
    {
        let params = [{ Name: name, Surname: surname, Phone: phone, Email: email, Gender: gender, Birthday: birthday }];
        let paramaters = JSON.stringify({ value: params });
        let data = postAjax("UpdateInformation", paramaters);
        let dataItem = JSON.parse(data.d);
        //------------------------------------------
        if (dataItem.result) {
            if (dataItem.items[0].isPhoneVerified == false) {
                $('#verifyModal').modal('toggle');
                //------------------------------------------
                let formGroup = document.querySelectorAll('.sms-code');
                formGroup.forEach(function (item, id) {
                    item.addEventListener('keyup', function (e) {
                        if (event.key >= 0 && event.key <= 9) {
                            formGroup[id].value = event.key;
                            if (id !== formGroup.length - 1) {
                                formGroup[id + 1].focus();
                            }
                        }
                    });
                })
            }
            else
                alertWithRedirect(getLang(1), dataItem.message, "success", window.location.pathname);
        }
        else if (dataItem.message == "needlogin")
            needLogin();
        else
            alert(getLang(3), dataItem.message, "error");
    }
    //------------------------------------------
    else { alert(getLang(3), getLang(4), "error"); }
});