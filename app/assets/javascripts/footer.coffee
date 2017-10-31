$(document).on 'turbolinks:load', ->
  app = new Vue
    el: '#footer',
    data:
      loading: true
      stats: []

    mounted: () ->
      this.$http.get('/utils/get_stats/')
      .then((res) ->
        app.stats = res.body
        app.loading = false
      )
      .then((res) ->
        app.loading = false
      )
