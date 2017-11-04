$(document).on 'turbolinks:load', ->

  if $('.customer_property').length
    app = new Vue
      el: '.customer_property',
      data:
        loading: false

      mounted: () ->
        self = this
        self.loading = true

        # this.$http.get('/customer_properties/read/')
        # .then((res) ->
        #   self.gallery.images = res.body.images
        #   self.loading = false
        # )

      methods:
        readCustomerProperty: (index) ->
          app.loading = true

          this.$http.get('/customer_properties/read/' + index)
          .then((res) ->
            app.gallery.images = res.body.images
            app.loading = false
          )
