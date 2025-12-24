if ($('#propertiesTable').length > 0) {
    var table = $('#propertiesTable').DataTable({
        order: false,
        pageLength: 100,
        dom: 'Bfrtip',
        buttons: [
            {
                extend: 'copyHtml5',
                exportOptions: {
                    columns: ':not(.noExport)' // "noExport" sınıfına sahip kolonlar dışlanır
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                    columns: ':not(.noExport)'
                }
            },
            {
                extend: 'csvHtml5',
                exportOptions: {
                    columns: ':not(.noExport)'
                }
            },
            {
                extend: 'pdfHtml5',
                exportOptions: {
                    columns: ':not(.noExport)'
                }
            }
        ]
    });
}

$(".btn-export-pdf").on("click", function () {
    $(".noExport").remove();
    $("#TableArea .dt-buttons, .dataTables_filter, .dataTables_info, .dataTables_paginate").remove();

    var button = $(this);

    Promise.all([
        captureAndUpload("#TableArea"),
        captureAndUpload("#AvailibilityArea")
    ]).then(function (paths) {
        let tableImagePath = paths[0];
        let availabilityImagePath = paths[1];

        if (tableImagePath && availabilityImagePath) {
            let params = [{
                RecordID: button.data("id"),
                Language: button.data("lang"),
                Properties: tableImagePath,
                AvailabilityPhoto: availabilityImagePath
            }];

            Swal.fire({
                title: "",
                text: getLang(27),
                timer: 2000,
                showConfirmButton: false
            }).then(function () {
                let data = postAjax("ExportProject", params);
                let dataItem = JSON.parse(data.d);
                if (dataItem.result) {
                    alert("", getLang(26), "success");
                    window.open(dataItem.message, '_blank');
                } else {
                    alert(getLang(1), dataItem.message, "error");
                }
            });
        }
    });
});

function captureAndUpload(selector) {
    return html2canvas(document.querySelector(selector)).then(function (canvas) {
        var base64 = canvas.toDataURL("image/png");
        var byteString = atob(base64.split(',')[1]);
        var mimeString = base64.split(',')[0].split(':')[1].split(';')[0];

        var ab = new ArrayBuffer(byteString.length);
        var ia = new Uint8Array(ab);
        for (var i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i);
        }
        var blob = new Blob([ab], { type: mimeString });

        var randomFileName = "area_" + new Date().toISOString().replace(/[-:.TZ]/g, "") + "_" + selector.replace("#", "") + ".png";
        var dataFiles = new FormData();
        dataFiles.append("UploadedFile", blob, randomFileName);

        return postAjaxFile("TableAsPNG", dataFiles);
    });
}