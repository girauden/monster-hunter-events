function initialize() {
  $('#datetimepicker').datetimepicker({
    format: 'DD/MM/YYYY, HH:mm',
    minDate: new Date(),
    sideBySide: true,
    buttons: {
      showClose: true
    }
  });

  $('#datetimepickerfinder').datetimepicker({
    format: 'DD/MM/YYYY, HH:mm',
    minDate: new Date(),
    sideBySide: true,
    buttons: {
      showClose: true
    }
  });
}

$(document).ready(initialize)
$(document).on('turbolinks:render', initialize)
