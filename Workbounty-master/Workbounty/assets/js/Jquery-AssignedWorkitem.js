function add(id) {
    var Data = {
        "UserID": id,
        "TeamID": document.getElementById("Teamid").value,
        "WorkitemID": document.getElementById("Workid").value
    };
    $.ajax({
        url: "/home/AssignedWorkitem/",
        type: "POST",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        dataType: "json",
        success: function (response) {
            alert("Workitem Alloted ")
            window.location.href = "/Home/dashboard/";
        },

        error: function (x, e) {
            alert("Error");
        }
    });
}