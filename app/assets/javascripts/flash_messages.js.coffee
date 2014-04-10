displayNoticeOrAlert = ->
  element = $('.alert,.notice')
  if element.text()
    console.log element.text()
    element.hide()
    $.jGrowl element.text(), 
      sticky: true
    element.remove()

document.addEventListener("page:load", displayNoticeOrAlert)
$ displayNoticeOrAlert