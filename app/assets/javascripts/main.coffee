$(window).scroll (e)->
  navbar = $('.navbar')
  header = $('.header')

  if navbar.length and header.length
    scroll = $(window).scrollTop();

    if scroll >= header.height()
      navbar.addClass('fixed-top');
    else
      navbar.removeClass('fixed-top');

$(document).on 'turbolinks:load', ->
  Vue.http.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')
  Vue.http.headers.credentials = 'same-origin'
