$("#ReportID").on("change", function () {

    let reportID = $(this).val();
    if (reportID != "0") {
        $("#ReportDetail").html("");
        let data = postAjax("GetDailyQuestions", reportID);
        let formData = "";
        let QuestionCount = 1;
        $.each(data.d, function () {
            formData += CreateQuestionItem(QuestionCount, this["Text"], this["Value"]);
            QuestionCount++;
        });
        $("#ReportDetail").html(formData);
        GetAnswers();
    }
});

/* create report file */
$(".btn-create-daily").on("click", function ()
{
    let reportID = $(this).data("id");
    //------------------------------------------
    let data = postAjax("CreatePDF", reportID);
    if (data.d != "false")
    {
        window.open(data.d, "_blank"); 
        alertWithRedirect(getLang(1), getLang("22"), "success", window.location.href);
    }
    else
        alert(getLang(3), getLang("23"), "error");
});

/* soru çıktısı */
function CreateQuestionItem(count, title, dataID) {
    return "<div class='form-group'><label>" + count + ". " + title + "</label><textarea id='Question" + dataID + "' data-id='" + dataID + "' class='form-control question-data' rows='4' required></textarea></div>";
}

/* soru cevapları */
function GetAnswers() {
    let RecID = GetQueryString("id");
    if (RecID != null) {
        let data = postAjax("GetDailyQuestionsAnswer", RecID);
        let Questions = [];
        let Answers = [];
        $.each(data.d, function () {
            let values = this["Value"].split(",");
            let text = this["Text"].split(",");
            values.forEach(function (value) {
                Questions.push(value.trim());
            });
            text.forEach(function (value) {
                Answers.push(value.trim());
            });
        });

        $.each(Questions, function (index, value) {
            let QuestionAnswer = Answers[index];
            $("#Question" + value).val(QuestionAnswer);
        });
    }
}
