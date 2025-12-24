function SetCookie(name, value, hours) {
    var expire = "";
    expire = new Date((new Date()).getTime() + hours * 3600000);
    expire = "; expires=" + expire.toGMTString();
    document.cookie = name + "=" + escape(value) + expire;
    return true;
}

function GetCookie(name) {
    var cookieValue = "";
    var search = name + "=";
    if (document.cookie.length > 0) {
        offset = document.cookie.indexOf(search);
        if (offset != -1) {
            offset += search.length;
            end = document.cookie.indexOf(";", offset);
            if (end == -1) end = document.cookie.length;
            cookieValue = unescape(document.cookie.substring(offset, end))
        }
    }
    return cookieValue;
}

if (GetCookie('cerez') !== 'zamazingo') {
    $(document).ready(function () {
        $("#popupModal").modal()
        $('#popupModal').on('hidden.bs.modal', function () {
            SetCookie('cerez', 'zamazingo', 1);  // cerez olusturduk her ziyaretçiye bir kere açılması için
            console.log("closed");
        });
    });
}
