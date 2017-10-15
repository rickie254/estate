$(document).on 'turbolinks:load', ->
  readURL = (input) ->
    if input.files.length > 0
      for file, index in input.files
        renderSpinner()

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
          renderUploadedImage(data.image)

  $("#property_images").change (e) ->
    readURL(this)

renderSpinner = () ->
  li = document.createElement("li")
  li.className = "list-inline-item"
  spinner = document.createElement("i")
  spinner.className = "fa fa-spinner fa-pulse fa-2x fa-fw"
  li.appendChild(spinner)
  document.getElementById("uploaded_property_images").appendChild(li)

renderUploadedImage = (image) ->
  li = document.getElementById("uploaded_property_images").lastChild
  li.removeChild(li.firstChild)
  div = document.createElement("div")
  div.style.backgroundImage = "url(" + image + ")"
  li.appendChild(div)
