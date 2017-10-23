$(document).on 'turbolinks:load', ->
  $('.form-check-input').bootstrapSwitch(onText: 'SIM', offText: 'NÃO', onColor: 'success', offColor: 'danger')
  $('.double').mask('#.##0,00', {reverse: true})

  if $('#property_form').length
    app = new Vue
      el: '#property_form',
      data:
        images: [],
        loading: false,
        gallerySuccess: '',
        extrasSuccess: '',
        galleryError: '',
        extrasError: ''
      mounted: () ->
        self = this
        self.loading = true
        this.$http.get('/properties/get_images/')
        .then((res) ->
          self.images = res.body.images
          self.loading = false
        )
      beforeUpdate: () ->
        gallerySuccess = extrasSuccess = galleryError = extrasError = ''

      methods:
        removeImage: (index) ->
          app.loading = true

          this.$http.delete('/properties/remove_image/' + index)
          .then((res) ->
            app.images = res.body.images
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
                  app.images = res.body.images
                  app.gallerySuccess = "Galeria atualizada"
                  app.loading = false
                (res) ->
                  console.log res
                  app.galleryError = "Imagem inválida"
                  app.loading = false
                )
