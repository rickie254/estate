$(document).on 'turbolinks:load', ->
  app = new Vue
    el: '#gallery',
    data:
      images: [],
      loading: false
    methods:

      removeImage: (index) ->
        app.loading = true

        $.ajax "/properties/remove_image/" + index,
        beforeSend: (xhr) ->
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]')
          .attr('content'))
        method: "DELETE",
        data: index,
        async: false,
        cache: false,
        contentType: false,
        processData: false,
        success: (data) ->
          app.images = data.images
          app.loading = false

      addImage: (e) ->
        app.loading = true
        files = e.target.files || e.dataTransfer.files;

        if files.length > 0
          for file, i in files

            formData = new FormData()
            formData.append("image", file)

            $.ajax "/properties/add_image",
            beforeSend: (xhr) ->
              xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]')
              .attr('content'))
            method: "POST",
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: (data) ->
              app.images = data.images
              app.loading = false
