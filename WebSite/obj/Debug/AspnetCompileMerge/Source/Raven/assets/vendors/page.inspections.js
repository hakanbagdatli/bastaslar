/* delete file */
$(".btn-book-inspection").on("click", function () {
    let id = $(this).data("id");
    let statu = $(this).data("statu");
    //------------------------------------------
    Swal.fire({
        title: getLang(5),
        text: getLang(16),
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: getLang(17),
        cancelButtonText: getLang(19)
    }).then(function (result) {
        if (result.value) {
            if (statu > 7)
                alert(getLang(3), getLang(20), "error");
            else {
                let params = [{ InspectionID: id, InspectionStatu: statu }];
                let data = postAjax("BookInspection", params);
                let dataItem = JSON.parse(data.d);
                if (dataItem.result)
                {
                    if (dataItem.result)
                        alertWithRedirect(getLang(1), dataItem.message, "success", window.location.href);
                    else
                        alert(getLang(3), dataConnect.message, "error");
                }
                else
                    alert(getLang(3), dataItem.message, "error");
            }

        }
    });
});