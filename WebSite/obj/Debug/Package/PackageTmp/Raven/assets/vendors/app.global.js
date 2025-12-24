/* genel uyarı şablonu */
function alert(Ititle, Itext, Iicon) {
    Swal.fire({
        title: Ititle,
        text: Itext,
        icon: Iicon,
        showConfirmButton: false
    });
};

/* uyarı sonrası yönlendirme */
function alertWithRedirect(Ititle, Itext, Iicon, IUrl) {
    Swal.fire({
        title: Ititle,
        text: Itext,
        icon: Iicon,
        showConfirmButton: false,
        timer: 4000
    }).then(function () {
        window.location = "" + IUrl + "";
    }), 400
};

/* set selectbox value */
function selectElement(id, valueToSelect) {
    let element = document.getElementById(id);
    element.value = valueToSelect;
}

/* ajax: id ve dil kodu verilen bilginin karşılığını language.json'dan getirir. */
function getLang(byID) {
    var langCode = postAjax("GetPartnerLang", "").d;
    var jsonUrl = '/raven/assets/language.json';
    var jsonText = $.ajax({ url: jsonUrl, async: false }).responseText;

    //console.log("byID:", byID);
    //console.log("langCode:", langCode);
    //console.log("JSON URL:", window.location.origin + jsonUrl);
    //console.log("JSON text:", jsonText);

    var json = JSON.parse(jsonText);
    var match = json.find(function (x) {
        //console.log("Checking x.id:", x.id, "==", byID);
        return x.id == byID;
    });

    //console.log("Match:", match);

    if (match && match[langCode])
        return match[langCode];

    return "[Metin bulunamadı]";
}



function SetLangCode(LanguageCode) {
    postAjax("SetLanguage", LanguageCode);
    window.location = window.location.href;
}

function SetCRMLang(LanguageCode) {
    postAjax("SetCRMLanguage", LanguageCode);
    window.location = window.location.href;
}

function SetPartnerLang(LanguageCode) {
    postAjax("SetPartnerLang", LanguageCode);
    window.location = window.location.href;
}

/* post ajax */
function postAjax(pageurl, dataString) {
    let paramaters = JSON.stringify({ value: dataString });
    return JSON.parse($.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "/Raven/Requests.asmx/" + pageurl,
        data: paramaters,
        datatype: "json",
        async: false
    }).responseText);
}

/* post ajax */
function postAjaxFile(pageurl, dataString) {
    let returningValue = "false";
    $.ajax({
        type: "POST",
        url: "/Raven/Requests.asmx/" + pageurl,
        data: dataString,
        contentType: false,
        processData: false,
        async: false,
        success: function (data) {
            returningValue = data.documentElement.textContent;
        },
        error: function () {
            returningValue = "false";
        }
    });
    return returningValue;
}

/* localstorage veri aktar */
function setLocalDB(item, text) { localStorage.setItem(item, text); }

/* dropdown doldur */
function FillDropdown(id, drpname, firstitem, data) {
    let drpDropdown = $("[id*=" + drpname + "]");
    drpDropdown.empty().append('<option selected="selected" value="0">' + firstitem + '</option>');
    $.each(data, function () {
        if (id != "") {
            if (this['Value'] == id) { drpDropdown.append($("<option selected></option>").val(this['Value']).html(this['Text'])); }
            else { drpDropdown.append($("<option></option>").val(this['Value']).html(this['Text'])); }
        }
        else { drpDropdown.append($("<option></option>").val(this['Value']).html(this['Text'])); }
    });
}

/* querystring getir */
function GetQueryString(param) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(param);
}
function sendFile(file, editor, welEditable) {
    let dataFiles = new FormData();
    dataFiles.append("UploadedFile", file);
    let dataName = postAjaxFile("EditorSaveFile", dataFiles);
    $(".summernote").summernote("insertImage", "/uploads/editor/" + dataName);

}

//seçilen x'e göre verileri getir
function SelectedChange(element, endpoint, target, triggerTarget = false) {
    if ($("#" + element).val() != null) {
        //------------------------------------------
        let selectedData = $("#" + target).data("value");
        let data = postAjax(endpoint, $("#" + element).val());
        //------------------------------------------
        FillDropdown("", target, "Please select", data.d, true);
        //------------------------------------------
        if (selectedData != null)
            $("#" + target).val(selectedData).prop('selected', true);
        //------------------------------------------
        if (triggerTarget)
            $("#" + target).trigger("change");
        //------------------------------------------
        if ($("#" + target).hasClass("multiselect")) {
            $("#" + target)[0].sumo.unload();
            $("#" + target).removeClass("SumoUnder");
            $("#" + target).SumoSelect({
                forceCustomRendering: true,
                search: true
            });
        }
        //------------------------------------------
        if ($("#" + target).hasClass("selectpicker")) 
            $("#" + target).selectpicker("refresh");
    }
}

//seçilen x'e göre verileri getir
function SelectedChangetoInput(element, endpoint, target)
{
    if ($("#" + element).val() != null) {
        let data = postAjax(endpoint, $("#" + element).val());
        if (data.d != null) {
            $("#" + target).val(data.d[0].Value);
        }
    }
}
/* active menu */
let active = $("#hdnMenuID").val();
$(".nav-item").each(function () {
    if (active == $(this).data("id")) {
        $(".nav-item .nav-link").removeClass("active");
        $(".aside-workspace .tab-pane").removeClass("show").removeClass("active");
        $(this).find(".nav-link").addClass("active");
        let target = $(this).find(".nav-link").data("target");
        $(target).addClass("show").addClass("active");
    }
});

/* eğer veri eklenecekse */
if ($("#id").length > 0) {
    if ($("#id").val() == "0")
    {
        $("input.form-data[type='text']").val("");
        let table = $("#table").val();
        if (table == "4" || table == "9")
            $("#CatID").val(GetQueryString("catid"));
        else 
            $(".form-data-option").val("0");
    }
}

$(document).ready(function ()
{
    /* init datatable */
    if ($('#liophinTable').length > 0) {
        var table = $('#liophinTable').DataTable({
            order: false,
            pageLength: 25,
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

    if ($('#liophinResTable').length > 0) {
        var table = $('#liophinResTable').DataTable({
            order: false,
            scrollY: '50vh',
            scrollX: true,
            scrollCollapse: true,
            pageLength: 25,
            dom: 'Bfrtip',
            buttons: [
                'copyHtml5',
                'excelHtml5',
                'csvHtml5',
                'pdfHtml5'
            ]
        });
    }

    /* setDropdown value */
    if ($(".form-data-option").length > 0) {
        $(".form-data-option").each(function () {
            let value = $(this).data("value");
            if (value != null) {
                $(this).val(value);
                $(this).trigger("change");
            }
        });
    }

});

let currentURL = window.location.pathname;
if (currentURL.includes("partner") == false) {
    $("#kt_aside").removeClass("opacity-0");
}