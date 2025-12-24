
$(".btn-callback").on("click", function () {

    let AgencyID = $(this).data("id");
    $("#CallbackID").val(AgencyID);
    $("#CalbackModal").modal();
});

$(".btn-save-callback").on("click", function ()
{
    Swal.fire({
        title: getLang(5),
        text: getLang(24),
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: getLang(25),
        cancelButtonText: getLang(19)
    }).then(function (result) {
        if (result.value) {
            //------------------------------------------
            let params = [{ id: 40, type: 3, properties: [] }];
            //------------------------------------------
            params[0].properties.push({ "type": "number", "name": "AgencyID", "value": $("#CallbackID").val() });
            params[0].properties.push({ "type": "text", "name": "CallbackType", "value": $("#CallbackType").val() });
            params[0].properties.push({ "type": "text", "name": "Description", "value": $("#Description").val() });
            //------------------------------------------
            let data = postAjax("Connect", params);
            let dataItem = JSON.parse(data.d);
            //------------------------------------------
            if (dataItem.result)
                alertWithRedirect(getLang(1), dataItem.message, "success", window.location.href);
            else
                alert(getLang(3), dataItem.message, "error");
        }
    });
});