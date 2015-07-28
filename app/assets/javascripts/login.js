$(document).ready(function () {
  $(".simple_form.new_user input").focus(function() {
    $('.alert.alert-danger').hide();
    $('.form-group').removeClass('has-error');
  });
});