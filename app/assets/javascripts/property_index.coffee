# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $("#filters-toggle").click ->
    if $('#filters').hasClass("d-none")
      $('#filters').removeClass("d-none")
      $("#filters-toggle").text("Ocultar filtros")
    else
      $('#filters').addClass("d-none")
      $("#filters-toggle").text("Mostrar filtros")
