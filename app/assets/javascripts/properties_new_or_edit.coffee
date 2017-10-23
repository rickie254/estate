$(document).on 'turbolinks:load', ->

  if $('#property_form').length
    app = new Vue
      el: '#property_form',
      data:
        loading: false,
        extra: '',
        extraList:
          list: [],
          error: '',
          success: ''
        gallery:
          images: [],
          errors:
            images: []
          success: ''

      mounted: () ->
        self = this
        self.loading = true

        this.$http.get('/properties/get_images/')
        .then((res) ->
          self.gallery.images = res.body.images
          self.loading = false
        )

        this.$http.get('/properties/get_extra_list/')
        .then((res) ->
          self.extraList.list = res.body.list
        )

      updated: () ->
        # if app.extraList.error
        #   app.extraList.error = ''

      methods:
        removeImage: (index) ->
          app.loading = true

          this.$http.delete('/properties/remove_image/' + index)
          .then((res) ->
            app.gallery.images = res.body.images
            app.loading = false
          )

        removeExtra: (index) ->
          app.loading = true

          this.$http.delete('/properties/remove_extra/' + index)
          .then((res) ->
            app.extraList.list = res.body.list
            app.loading = false
          )

        addExtra: () ->
          app.loading = true

          this.$http.post('/properties/add_extra/', {extra: app.extra})
          .then(
            (res) ->
              console.log res
              app.extraList.list = res.body.list
              app.extraList.success = "Informações adicionais atualizadas"
              app.extra = ''
              app.extraList.error = ''
              app.loading = false
            (res) ->
              console.log res
              app.extraList.error = res.bodyText
              app.loading = false
            )

        addImage: (e) ->
          files = e.target.files || e.dataTransfer.files;
          app.loading = true

          if files.length > 0
            for file, i in files

              formData = new FormData()
              formData.append('image', file)

              this.$http.post('/properties/add_image/', formData)
              .then(
                (res) ->
                  console.log res
                  app.gallery.images = res.body.images
                  app.gallery.success = "Galeria atualizada"
                  app.loading = false
                (res) ->
                  console.log res
                  app.gallery.errors = res.body
                  app.loading = false
                )

  $('.form-check-input').bootstrapSwitch(onText: 'SIM', offText: 'NÃO', onColor: 'success', offColor: 'danger')
  $('.double').mask('#.##0,00', {reverse: true})
