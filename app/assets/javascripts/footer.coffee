$(document).on 'turbolinks:load', ->
  app = new Vue
    el: '#footer',
    data:
      incc: {}

    mounted: () ->
      # this.$http.get('/utils/get_incc/')
      # .then((res) ->
      #   console.log res
      #   app.incc = res.body.incc
      # )
