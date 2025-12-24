/* formu gönder */
$(".btn-send-data").on("click", function () {
    let prefix = "." + $(this).data("prefix") + "-form-data";
    let formID = $(this).data("form");
    let params = [{ id: formID, properties: [] }];
    let canSend = true;
    //------------------------------------------
    $(prefix).each(function () {
        let dataID = $(this).attr("id");
        let dataName = $(this).data("field");
        let dataType = $(this).attr("type");
        let dataValue = $(this).val();
        //------------------------------------------
        if (dataID != "Kvkk" && dataValue != null && dataValue != "")
        {
            if (dataType == "option")
                dataValue = $("#" + dataID + " option:selected").text();
            //------------------------------------------
            else if (dataType == "checkbox") {
                if ($(this).prop("checked"))
                    dataValue = 1;
                else
                    dataValue = 0;
            }
            //------------------------------------------
            if (dataType == "radio") {
                if ($(this)[0].checked == true)
                    params[0].properties.push({ "id": dataID, "type": dataType, "name": dataName, "value": dataValue });
            }
            else
                params[0].properties.push({ "id": dataID, "type": dataType, "name": dataName, "value": dataValue });

        }
        //------------------------------------------
        else if ($("#" + dataID).prop('required')) {
            if (dataType == "checkbox") {
                if ($(this)[0].checked == false) {
                    canSend = false;
                    alert(getLang(2), getLang(4), "warning");
                }
            }
            else {
                canSend = false;
                alert(getLang(2), getLang(4), "warning");
            }

        }
    });
    //------------------------------------------
    if (canSend)
    {
        let data = postAjaxData("SendData", params);
        let dataItem = JSON.parse(data.d);
        if (dataItem.result)
        {
            let redirect = dataItem.redirect;
            //------------------------------------------
            if (redirect == "self") 
                redirect = window.location.href;
            else if (redirect == "path")   
                redirect = window.location.pathname;
            //------------------------------------------
            if (formID == 102) //api user login
            {
                let remember = $("#ckRemember")[0].checked;
                if (remember == true) {
                    setLocalDB("gtmuser", $("#UserEmail").val());
                    setLocalDB("gtmpass", $("#UserPassword").val());
                }
                //------------------------------------------
                alertWithRedirect(getLang(1), dataItem.message, "success", redirect);
            }
            //------------------------------------------
            else 
                alertWithRedirect(getLang(1), dataItem.message, "success", redirect);
        }
        else 
            alert(getLang(3), dataItem.message, "error");
    }
});

/* delete data */
$(".btn-delete-data").on("click", function () {
    let formID = $(this).data("form");
    let dataID = $(this).data("id");
    //------------------------------------------
    swal({
        title: getLang(11),
        text: getLang(12),
        icon: "warning",
        buttons: true,
        dangerMode: true,
        buttons: ["Hayır!", "Evet, sil."]
    }).then((willDelete) => {
        if (willDelete) {
            //------------------------------------------
            let params = [{ id: formID, properties: [] }];
            params[0].properties.push({ "id": "id", "type": "int", "value": parseInt(dataID) });
            params[0].properties.push({ "id": "Approved", "type": "int", "value": "0" });
            params[0].properties.push({ "id": "isDeleted", "type": "int", "value": "1" });
            //------------------------------------------
            let data = postAjaxData("SendRemote", params);
            let dataItem = JSON.parse(data.d);
            //------------------------------------------
            if (dataItem.result)
                alertWithRedirect(getLang(1), dataItem.message, "success", window.location.href);
            else
                alert(getLang(3), dataItem.message, "error");
        }
    });
});