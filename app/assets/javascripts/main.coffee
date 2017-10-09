$(window).scroll (e)->
  navbar = $('.navbar')
  header = $('.header')

  if navbar.length and header.length
    scroll = $(window).scrollTop();

    if scroll >= header.height()
      navbar.addClass('fixed-top');
    else
      navbar.removeClass('fixed-top');
