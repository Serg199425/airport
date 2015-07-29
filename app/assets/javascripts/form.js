$(document).ready(function () {
  $("form input").focus(function() {
    $('.alert.alert-danger').hide();
    $('.form-group').removeClass('has-error');
  });
});