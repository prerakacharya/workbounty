$(document).ready(function () {
    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy',
    }).on('changeDate', function (e) {
        $(this).datepicker('hide');
    });
});