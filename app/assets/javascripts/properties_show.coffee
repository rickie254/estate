$(document).on 'turbolinks:load', ->
  if $("#property-gallery").length
    $("#property-gallery").lightGallery
      selector: ".gallery-image"

@facebookShare = () ->
  FB.ui
    method: 'share',
    href: window.location.href
  ,(response) ->

@twitterShare = () ->
  popupCenter("https://twitter.com/intent/tweet?url=" + window.location.href, '_blank', 600, 270);


popupCenter = (url, title, w, h) ->
  dualScreenLeft = if window.screenLeft != undefined then window.screenLeft else screen.left
  dualScreenTop = if window.screenTop != undefined then window.screenTop else screen.top

  width = if window.innerWidth then window.innerWidth else if document.documentElement.clientWidth then document.documentElement.clientWidth else screen.width
  height = if window.innerHeight then window.innerHeight else if document.documentElement.clientHeight then document.documentElement.clientHeight else screen.height

  left = ((width / 2) - (w / 2)) + dualScreenLeft
  top = ((height / 2) - (h / 2)) + dualScreenTop
  newWindow = window.open(url, title, 'toolbar=0,location=0,menubar=0,scrollbars=0, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left)

  if window.focus
    newWindow.focus()
