$(document).on 'turbolinks:load', ->
  $("#property-gallery").lightGallery
    selector: ".gallery-image"

  googleMapsClient = require('@google/maps').createClient(
    key: 'AIzaSyCoAJkudn_hQi15Pf45XsTyoDjBV1luBBM'
  )
