$(document).on 'turbolinks:load', ->
  app = new Vue
    el: '#property-filter-dropdown',
    data:
      loading: true
      available: {}

    mounted: () ->
      this.$http.get('/utils/get_available_properties/')
      .then((res) ->
        console.log res
        app.available = res.body
        app.loading = false
      )
      .then((res) ->
        app.loading = false
      )
