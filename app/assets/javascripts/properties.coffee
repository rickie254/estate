$(document).on 'turbolinks:load', ->

  app = new Vue
    el: '#gallery',
    data:
      images: [],
      loading: false
    mounted: () ->
      self = this
      self.loading = true
      this.$http.get('/properties/get_images/')
      .then((res) ->
        self.images = res.body.images
        self.loading = false
      )

    methods:
      removeImage: (index) ->
        app.loading = true

        this.$http.delete("/properties/remove_image/" + index)
        .then((res) ->
          app.images = res.body.images
          app.loading = false
        )

      addImage: (e) ->
        files = e.target.files || e.dataTransfer.files;
        console.log files
        app.loading = true

        if files.length > 0
          for file, i in files

            formData = new FormData()
            formData.append("image", file)

            this.$http.post("/properties/add_image/", formData)
            .then((res) ->
              app.images = res.body.images
              app.loading = false
            )
