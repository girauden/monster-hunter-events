
loadModalProcess = ->

  resetModal = ->
    deleteModal()
    deleteListener closeButton, windowOnClick
    return

  windowOnClick = (event) ->
    contentChilds = document.querySelectorAll('.modal-background *')
    console.log(event.target)
    matchingClick = 0
    matchingClick++ for contentChild in contentChilds when event.target is contentChild
    console.log(matchingClick)
    resetModal() if matchingClick is 0
    return

  closeButton = document.querySelector('.modal-close-button')
  closeButton.addEventListener 'click', resetModal
  window.addEventListener 'click', windowOnClick
  return

$(document).ajaxComplete loadModalProcess

deleteModal = ->
  console.log('modal')
  $('.modal-background').remove()
  return

deleteListener = (closeButton, windowOnClick) ->
  console.log('listener')
  closeButton.removeEventListener 'click', deleteModal
  window.removeEventListener 'click', windowOnClick
  return



