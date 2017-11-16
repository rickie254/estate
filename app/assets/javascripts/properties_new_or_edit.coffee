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

      methods:
        setMainImage: (index) ->
          app.loading = true

          this.$http.get('/properties/set_main_image/' + index)
          .then((res) ->
            app.gallery.images = res.body.images
            app.loading = false
          )

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
              app.extraList.list = res.body.list
              app.extraList.success = "Informações adicionais atualizadas"
              app.extra = ''
              app.extraList.error = ''
              app.loading = false
            (res) ->
              app.extraList.error = res.bodyText
              app.loading = false
            )

        addImage: (e) ->
          files = e.target.files || e.dataTransfer.files;

          if files.length > 0

            for file, i in files
              formData = new FormData()
              formData.append('image', file)
              @uploadImage(formData)

        uploadImage: (formData) ->
          app.loading = true if app.loading == false

          this.$http.post('/properties/add_image/', formData)
          .then(
            (res) ->
              app.gallery.images = res.body.images
              app.gallery.success = "Galeria atualizada"
              app.gallery.errors = {images: []}
              app.loading = false
            (res) ->
              app.gallery.success = ""
              app.gallery.errors = res.body
              app.loading = false
            )


    $('.form-check-input').bootstrapSwitch(onText: 'SIM', offText: 'NÃO', onColor: 'success', offColor: 'danger')
    $('.double').mask('#.##0,00', {reverse: true})
