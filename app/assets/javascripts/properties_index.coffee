$(document).on 'turbolinks:load', ->
  $("#filters-toggle").click ->
    if $('#filters').hasClass("d-none")
      $('#filters').removeClass("d-none")
      $("#filters-toggle").text("Ocultar filtros")
    else
      $('#filters').addClass("d-none")
      $("#filters-toggle").text("Mostrar filtros")
