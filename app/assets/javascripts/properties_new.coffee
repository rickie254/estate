$(document).on 'turbolinks:load', ->
  console.log "existe algo"
  readURL = (input) ->
      if input.files and input.files[0]
        console.log input.files
        reader = new FileReader()

        reader.onload = (e) ->
          $('.property_image').attr('src', e.target.result)
        reader.readAsDataURL(input.files[0])

    $("#house_images").change (e) ->
      readURL(this)

    return
