/* kaydet */
$(".btn-save-data").on("click", function () {

    let table = $("#table").val();
    let type = $("#id").val() > 0 ? 4 : 3;
    let returnURL = type == 3 ? window.location.href.replace("dhx=add&", "").replace("dhx=add", "") : window.location.href;
    let params = [{ id: table, type: type, properties: [] }];
    let dataCatID = 0;
    let dataRecordID = 0;
    let dataPageType = 0;
    let dataTitle = "";
    let canSend = true;
    let clientCount = 0;
    if (table == "39")
    {
        let Questions = [];
        let Answers = [];
        $(".question-data").each(function ()
        {
            let answerValue = $(this).val().toString();
            if (answerValue == "")
            {
                if ($(this).prop('required') && dataValue != "on") {
                    canSend = false;
                    alert(getLang(2), getLang(4), "warning");
                }
            } else
            {
                Questions.push($(this).data("id"));
                Answers.push(answerValue.replaceAll(",", ""));
            }
        });
        $("#Questions").val(Questions.join(","));
        $("#Answers").val(Answers.join(","));
    }
    //------------------------------------------
    $(".form-data").each(function () {
        let dataID = $(this).attr("id");
        let dataType = $(this).attr("type");
        let dataMultiple = $(this).hasClass("multiselect");
        let dataTagify = $(this).hasClass("tagify");
        let isRequired = $(this).prop('required');
        let dataValue = $(this).val().toString();
        //------------------------------------------
        if (dataID != null && dataValue != null)
        {
            if ((dataValue == "" || dataValue == "0") && isRequired == true)
            {
                if ($(this).prop('required') && dataValue != "on") {
                    canSend = false;
                    alert(getLang(2), getLang(4), "warning");
                }
            }
            else
            {
                if (dataID == "id" && type == 3)
                    console.log("deleted id item")
                else {
                    if (dataID == "Title")
                        dataTitle = dataValue;
                    //------------------------------------------
                    else if (dataID == "PageTypeID")
                        dataPageType = dataValue;
                    //------------------------------------------
                    else if (dataID == "CatID")
                        dataCatID = dataValue;
                    //------------------------------------------
                    else if (dataID == "id")
                        dataRecordID = dataValue;
                    //------------------------------------------
                    else if (dataID == "Clients") {
                        let array = JSON.parse(dataValue);
                        dataValue = array.map(item => item.value).join(',');
                        clientCount = array.length;
                    }
                    //------------------------------------------
                    else if (dataID == "ClientsBudget") {
                        let array = JSON.parse(dataValue);
                        dataValue = array.map(item => item.value).join(',');
                        if (clientCount != array.length) {
                            canSend = false;
                            alert(getLang(2), getLang(21), "warning");
                        }
                    }
                    //------------------------------------------
                    if (dataType == "file") {
                        let dataFiles = new FormData();
                        let files = $("#" + dataID).get(0).files;
                        if (files.length > 0) {
                            if (dataTitle == "")
                                dataTitle = dataID;
                            //------------------------------------------
                            dataFiles.append("Table", table);
                            dataFiles.append("Title", dataTitle);
                            dataFiles.append("PageType", dataPageType);
                            dataFiles.append("CatID", dataCatID);
                            dataFiles.append("RecordID", dataRecordID);
                            dataFiles.append("SavingPath", $(this).data("path"));
                            dataFiles.append("Crop", $(this).data("crop"));
                            dataFiles.append("UploadedFile", files[0]);
                            dataValue = postAjaxFile("SaveFile", dataFiles);
                        }
                        else
                            return true;
                    }
                    //------------------------------------------
                    else if (dataType == "checkbox")
                        dataValue = Number($("#" + dataID)[0].checked);
                    //------------------------------------------
                    //if (dataMultiple && dataValue != "") 
                    //    dataValue = "," + dataValue.replaceAll(",", ",,") + ","
                    //------------------------------------------
                    if (dataValue != null) {
                        if (dataTagify == false)
                            params[0].properties.push({ "type": dataType, "name": dataID, "value": dataValue });
                    }

                }
            }
        }
        else if (dataValue == null)
        {
            if ($(this).prop('required')) {
                canSend = false;
                alert(getLang(2), getLang(4), "warning");
            }

        }
    });
    //------------------------------------------
    if (canSend)
    {
        let data = postAjax("Connect", params);
        let dataItem = JSON.parse(data.d);
        //------------------------------------------
        if (dataItem.result)
            alertWithRedirect(getLang(1), dataItem.message, "success", returnURL);
        else
            alert(getLang(3), dataItem.message, "error");
    }

});

/* liste verilerini güncelle */
$(".btn-save-list").on("click", function () {

    let data = "";
    $(".list-data").each(function () {
        let table = $("#table").val();
        let params = [{ id: table, type: 7, properties: [] }];
        params[0].properties.push({ "name": "id", "value": $(this).data("id") });
        $(this).find('.list-form-data').each(function () {
            let dataID = $(this).attr("id");
            let dataType = $(this).attr("type");
            let dataName = $(this).attr("name");
            let dataValue = $("#" + dataID).val();
            //------------------------------------------
            if (dataType == "checkbox")
                dataValue = Number($(this)[0].checked);
            //------------------------------------------
            if (dataValue != null)
            {
                params[0].properties.push({ "type": dataType, "name": dataName, "value": parseInt(dataValue) });
                //------------------------------------------
                if (table == 32 && dataName == "Approved" && dataValue == 1) 
                    params[0].properties.push({ "type": "number", "name": "Statu", "value": parseInt(2) });
                else if (table == 32 && dataName == "Approved" && dataValue == 0)
                    params[0].properties.push({ "type": "number", "name": "Statu", "value": parseInt(1) });
            }
        });
        data = postAjax("Connect", params);
    });
    //------------------------------------------
    if (data != "") {
        let dataItem = JSON.parse(data.d);
        //------------------------------------------
        if (dataItem.result)
            alertWithRedirect(getLang(1), dataItem.message, "success", window.location.href);
        else
            alert(getLang(3), dataItem.message, "error");
    }
});