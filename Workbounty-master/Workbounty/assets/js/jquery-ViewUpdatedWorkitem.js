function ApplyReward(item) {
    var id = {
        "UserID": $(item).attr("id"),
        "WorkitemID": $("#Workid").val(),
    };

    $.ajax({
        url: "/workitem/PayReward/",
        type: "POST",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(id),
        dataType: "json",
        success: function (response) {
            if (response == "Success") {
                alert("Success");
                window.location.href = "/Home/Dashboard/";
            }
        },

        error: function (x, e) {
            alert("Error");


        }
    });

}