$(document).ready(function () {
    $("#recent-box1").hide();

});


function add(item) {
    var id = $(item).attr("id");
    var memberData = {
        "UserID": id,
        "IsActive": true,
        "TeamName": $("#txtTeamName").val(),
        "TeamUserInfoID": $("#teamid").val()
    };
    $.ajax({
        url: "/Team/AddMember",
        type: "POST",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(memberData),
        dataType: "json",
        success: function (response) {
            alert("Member Added ")
            item.remove()
        },
        error: function (x, e) {
            alert("Error");
        }
    });
}

function show() {
    $("#simple-table tr").remove();
    var id = $('#itId').val();
    $.getJSON("/api/FindMember/" + id,

            function (Data) {
                $("#simple-table").append('<tr><th>Member Name</th><th>Email</th><th>Action</th></tr>');
                var arrayLength = Data.length;
                for (var i = 0; i < arrayLength; i++) {
                    $("#simple-table").append('<tr><td>' + Data[i].FirstName + '</td><td>' + Data[i].Email + '</td><td><input type="button" id=' + Data[i].UserID + ' value="Add Member" onclick="add(this); return false;" class="btn btn-minier btn-purple" /></td></tr>');
                }


            })

        .fail(

            function (jqXHR, textStatus, err) {

                alert('Error: ' + err);

            });

}

function submit() {
  
    var teamData = {
        "TeamName": $("#txtTeamName").val(),
        "UserID": $("#Userid").val(),
        "IsActive": false,
        "TeamUserInfoID": $("#Userid").val()
    };

    $.ajax({
        url: "/Team/Addteam",
        type: "POST",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(teamData),
        dataType: "json",
        success: function (response) {
            alert("Team Added ")
            $("#recent-box1").show()
        },
        error: function (x, e) {
            alert("Error");
        }
    });
}