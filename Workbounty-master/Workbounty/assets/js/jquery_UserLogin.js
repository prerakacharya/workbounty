$(function () {
    $("#loginButton").click(function (e) {
        e.preventDefault();
        var id = {

            "Email": $("#Email").val(),
            "Password": $("#Password").val()
        };



        $.ajax({
            url: "/Home/Login/",
            type: "POST",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(id),
            dataType: "json",
            success: function (response) {
                console.log(response);
                if (response.success) {
                    location.href = response.redirectURL;
                }
                else {
                    alert(response.message);
                }
            },

            error: function (x, e) {
                alert('Failed');
                alert(x.responseText);
                alert(x.status);

            }
        });
    });
});