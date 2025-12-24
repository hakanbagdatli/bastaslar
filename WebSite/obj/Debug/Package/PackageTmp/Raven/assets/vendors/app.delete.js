/* delete data */
function Delete(id) {

    Swal.fire({
        title: getLang(5),
        text: getLang(6),
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Evet, sil.",
        cancelButtonText: "Hayır!"
    }).then(function (result) {
        if (result.value) {
            //------------------------------------------
            let table = $("#table").val();
            let type = false;
            let params = [{ id: table, type: 5, properties: [] }];
            //------------------------------------------
            params[0].properties.push({ "type": "number", "name": "id", "value": id });
            params[0].properties.push({ "type": "number", "name": "Approved", "value": "0" });
            params[0].properties.push({ "type": "number", "name": "isDeleted", "value": "1" });
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
}

/* delete file */
$(".btn-delete-file").on("click", function ()
{
    let field = $(this).data("field");
    let path = $(this).data("path");
    let name = $(this).data("value");
    //------------------------------------------
    Swal.fire({
        title: getLang(5),
        text: getLang(6),
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: getLang(18),
        cancelButtonText: getLang(19)
    }).then(function (result) {
        if (result.value) {
            //------------------------------------------
            let table = $("#table").val();
            let type = 5;
            let deleteParams = [{ table: table, field: field, filepath: path, filename: name }];
            let data = postAjax("DeleteFile", deleteParams);
            let dataItem = JSON.parse(data.d);
            if (dataItem.result) {
                //------------------------------------------
                let dataParams = [{ id: table, type: type, properties: [] }];
                dataParams[0].properties.push({ "type": "number", "name": "id", "value": $("#id").val() });
                dataParams[0].properties.push({ "type": "text", "name": field, "value": "" });
                data = postAjax("Connect", dataParams);
                let dataConnect = JSON.parse(data.d);
                //------------------------------------------
                if (dataConnect.result)
                    alertWithRedirect(getLang(1), dataItem.message, "success", window.location.href);
                else
                    alert(getLang(3), dataConnect.message, "error");
            }
            else
                alert(getLang(3), dataItem.message, "error");

        }
    });
});