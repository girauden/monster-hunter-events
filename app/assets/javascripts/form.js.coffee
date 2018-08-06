$('#form-container-hunt').hide()
$('.show-hide-label').hide()

$('#hunt-selector-show').click ->
  $('#form-container-hunt').show()
  $('#show-hide-form-hunt').hide()

$('#hunt-voice-chat').click ->
  $('.show-hide-label').show()


$('#form-container-hunt-finder').hide()
$('.show-hide-finder-label').hide()

$('#finder-selector-show').click ->
  $('#form-container-hunt-finder').show()

$('#hunt-voice-chat-finder').click ->
  $('.show-hide-finder-label').show()
