$(document).on 'turbolinks:load', ->
  app = new Vue
    el: '#footer',
    data:
      stats: []

    mounted: () ->
      this.$http.get('/utils/get_stats/')
      .then((res) ->
        app.stats = res.body
        console.log app.stats
      )
