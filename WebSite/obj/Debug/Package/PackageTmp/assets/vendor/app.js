/* genel uyarı şablonu */
function alert(Ititle, Itext, Iicon) {
    swal({
        title: Ititle,
        text: Itext,
        icon: Iicon,
        button: {
            visible: false,
        },
    });
};

/* uyarı sonrası yönlendirme */
function alertWithRedirect(Ititle, Itext, Iicon, IUrl) {
    swal({
        title: Ititle,
        text: Itext,
        icon: Iicon,
        button: {
            visible: false,
        },
        timer: 3000
    }).then(function () {
        window.location = "" + IUrl + "";
    }), 400
};

/* ajax: id ve dil kodu verilen bilginin karşılığını language.json'dan getirir. */
function getLang(byID) {
    return JSON.parse($.ajax({ url: '/assets/language.json', async: false }).responseText).filter(x => x.ID == byID)[0]["EN"];
}

/* post ajax */
function postAjax(PageURL, Parameters) {
    return JSON.parse($.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "/AjaxRequest.asmx/" + PageURL,
        data: Parameters,
        datatype: "json",
        async: false
    }).responseText);
}

/* post ajax data */
function postAjaxData(pageurl, dataString) {
    let paramaters = JSON.stringify({ value: dataString });
    return JSON.parse($.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "/AjaxRequest.asmx/" + pageurl,
        data: paramaters,
        datatype: "json",
        async: false
    }).responseText);
}

/* post ajax file */
function postAjaxFile(dataString) {
    let returningValue = "false";
    $.ajax({
        type: "POST",
        url: "/AjaxRequest.asmx/SaveFile",
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

/* localstorage veri aktar */
function setLocalDB(item, text) {
    localStorage.setItem(item, text);
}

/* cookie veri aktar */
function setCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

/* cookie'den veri getir */
function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}


/* tarih formatına çevir */
function ConvertDateFormat(inputDate) {
    var parts = inputDate.split(".");
    var newDate = new Date(parts[2], parts[1] - 1, parts[0], 16, 3, 30);
    return newDate;
}

/* equalize */
!function (e) {
    "use strict";
    e.fn.equalize = function (t) {
        var i = this, n = e.extend({ selector: ".item" }, t);
        e(window).on("load resize", function () {
            i.each(function () {
                var t = 0;
                e(n.selector, this).each(function () {
                    e(this).height() > t && (t = e(this).height())
                }), e(n.selector, this).height(t)
            })
        })
    }
}(jQuery);

if ($("[data-equalize]").length > 0) {
    $("[data-equalize]").equalize({
        selector: "[data-equalize-item]"
    });
}

/* change language */
$(".btn-language").on("click", function () {
    let LangID = $(this).data("id");
    let LanguageCode = $(this).data("language");
    $("link[rel='alternate'][hreflang='" + LanguageCode + "']").each(function () {
        var baseURL = $(this).attr('href');
        if (baseURL)
            window.location = baseURL;
    });
});