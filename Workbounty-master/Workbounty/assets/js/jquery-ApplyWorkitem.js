function register() {

    var item = {
        "WorkitemID": document.getElementById("Workid").value,
        "UserID": document.getElementById("Userid").value,
        "IsExclusive": document.getElementById("open").value,
        "IsFavourite": false,
        "IsRegistered": true
    };

    $.ajax({
        type: "POST",
        url: "/workitem/ApplyWorkitem/",
        data: JSON.stringify(item),
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        processData: true,
        success: function (data, status, xhr) {
            alert("The result is : " + status);
        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });
}