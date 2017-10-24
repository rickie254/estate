$(window).scroll (e)->
  navbar = $('.navbar')
  header = $('.header')
  container = $('.container')

  if navbar.length and header.length
    scroll = $(window).scrollTop()

    if scroll >= header.height()
      navbar.addClass('fixed-top')
      container.css('padding-top', '75px')
    else
      navbar.removeClass('fixed-top')
      container.css('padding-top', '30px')

$(document).on 'turbolinks:load', ->
  Vue.http.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')
  Vue.http.headers.credentials = 'same-origin'
