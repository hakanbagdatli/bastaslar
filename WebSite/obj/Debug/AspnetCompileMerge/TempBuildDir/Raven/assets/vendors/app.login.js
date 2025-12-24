$(document).ready(function () {
    RememberUseraname();
});

/* beni hatırla seçeneği aktif ise */
function RememberUseraname() {
    if (localStorage.getItem("ravenuser") != null) {
        $("#username").val(localStorage.getItem("ravenuser"));
        $("#password").val(localStorage.getItem("ravenpass"));
        $('#ckRemember').prop('checked', true)
    }
}

/* email ve şifre ile login işlemi */
$(".btn-login").on("click", function () {
    let email = $("#username").val();
    let pass = $("#password").val();
    let remember = document.getElementById("ckRemember").checked;
    //------------------------------------------
    if (email != "" && pass != "") {

        let params = [{ Email: email, Password: pass }];
        let data = postAjax("Login", params);
        let dataItem = JSON.parse(data.d);
        //------------------------------------------
        if (dataItem.result) {
            //------------------------------------------
            if (remember == true) { setLocalDB("ravenuser", email); setLocalDB("ravenpass", pass); }
            //------------------------------------------
            alertWithRedirect("", dataItem.message, "success", "/raven/dashboard");
            //------------------------------------------
        }
        else
            alert(getLang(1), dataItem.message, "error");
    }
    //------------------------------------------
    else { alert(getLang(2), getLang(4), "warning"); }
});

/* email ve şifre ile login işlemi */
$(".btn-forgot-password").on("click", function () {
    let email = $("#txtForgotPassword").val();
    //------------------------------------------
    if (email != "") {

        let params = [{ Email: email }];
        let data = postAjax("103", params);
        let dataItem = JSON.parse(data.d);
        //------------------------------------------
        if (dataItem.result)
            alertWithRedirect("", dataItem.message, "success", window.location.pathname);
        else
            alert(getLang(3), dataItem.message, "error");
    }
    //------------------------------------------
    else { alert(getLang(2), getLang(4), "warning"); }
});