var radioValue;
var amount;
var filepath;

$(document).ready(function () {

    $("#btn").click(function () {

        var radioValue = $("input[name='formfieldradio']:checked").val();
        var amount = $("#amount").val();
        sessionStorage.setItem('key1', radioValue);
        sessionStorage.setItem('key2', amount);
        $("#myModal").fadeOut();
    });
});

function AddWorkitem() {

    var d = new Date();
   
    var newitem = {};
        newitem.Title = $("#Title").val();
        newitem.Summary= $("#Summary").val();
        newitem.StartDate= $("#StartDate").val();
        newitem.DueDate = $("#DueDate").val();
        newitem.PublishedTo= $("#TeamName1").val();
        newitem.DocumentFilePath = document.getElementById("myFile").value;
        newitem.ProposedReward = sessionStorage.getItem('key1');
        newitem.Amount = sessionStorage.getItem('key2');
        newitem.CreatedBy = document.getElementById("Userid").value;
        newitem.CreatedDateTime = d.toDateString();
        newitem.ModifyBy = document.getElementById("Userid").value;
        newitem.ModifyDateTime = d.toDateString();
        newitem.Status = true;
        newitem.Remarks = "Good";
        newitem.IsOpenForGroup = true;
   
   
    if ($("#Title").val() == "") {
        $("#TitleError").text("Title is Required");

        if ($("#Summary").val() == "") {
            $("#SummaryError").text("Summary is Required");

            if ($("#StartDate").val() == "") {
                $("#StartdateError").text("Start Date is Required");

                if ($("#DueDate").val() == "") {
                    $("#DuedateError").text("Due Date is Required");

                    if ($("#amount").val() == "") {
                        $("#AmountError").text("Amount is Required");
                    }
                }
            }
        }
    }
    else {
        $.ajax({
            type: "POST",
            url: '/home/AddWorkitem/',
            data: JSON.stringify({ addWorkitemData: newitem }),
            contentType: "application/json;charset=utf-8",
            processData: true,
        success: function (response) {
            console.log(response);
            if (response.IsSuccess)
            {
                
                alert(response.successAddWorkitemMessage);
                location.href = response.redirectURL;
            }
            else
            {
                alert(response.successAddWorkitemMessage);
            }
            },
            error: function (xhr) {
                alert(xhr.responseText);
            }
        });
    }
    
}
