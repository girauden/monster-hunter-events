modalProcess = ->
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
  closeButton.addEventListener 'click', resetModal unless (closeButton == null)
  window.addEventListener 'click', windowOnClick
  return

loadModalProcess = ->
  modal = document.querySelector('.modal-content')
  modalProcess()unless modal == null

$(document).ajaxComplete loadModalProcess

deleteModal = ->
  console.log('modal')
  $('.modal-background').remove()
  return

deleteListener = (closeButton, windowOnClick) ->
  console.log('listener')
  closeButton.removeEventListener 'click', deleteModal unless (closeButton == null)
  window.removeEventListener 'click', windowOnClick
  return



