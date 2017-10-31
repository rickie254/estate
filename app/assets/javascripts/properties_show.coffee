$(document).on 'turbolinks:load', ->
  if $("#property-gallery").length
    $("#property-gallery").lightGallery
      selector: ".gallery-image"
