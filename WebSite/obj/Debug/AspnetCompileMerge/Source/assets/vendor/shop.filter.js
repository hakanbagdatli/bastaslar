/* fitrele */
$(".btn-filter").on("click", function ()
{
    let returnUrl = "", product = "", color = "", size = "";
    let prefix = "." + $(this).data("prefix") + "-filter-data";
    //------------------------------------------
    $(prefix).each(function ()
    {
        let id = $(this).attr("id");
        let dataID = $(this).data("id");
        let dataCatID = $(this).data("cat");
        let dataTitle = $(this).data("title");
        //------------------------------------------
        if ($("#" + id).prop("checked")) {
            if (dataCatID == "product")
                product += dataID + ",";
            if (dataCatID == "color")
                color += dataID + ",";
            if (dataCatID == "size")
                size += dataID + ",";
        }
    });
    //------------------------------------------
    if (product.length > 0) {
        product = product.substring(0, product.length - 1);
        returnUrl += "&product=" + product;
    } else {
        returnUrl += "&product=" + $("#ctl00_lhdmcatId").val();
    }
    //------------------------------------------
    if (color.length > 0) {
        color = color.substring(0, color.length - 1);
        returnUrl += "&color=" + color;
    }
    if (size.length > 0) {
        size = size.substring(0, size.length - 1);
        returnUrl += "&size=" + size;
    }
    //------------------------------------------
    if (returnUrl.length > 0) {
        returnUrl = returnUrl.substring(1);
        window.location = "/urun-arama?" + returnUrl;
    }
});