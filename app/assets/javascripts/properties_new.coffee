$(document).on 'turbolinks:load', ->
  readURL = (input) ->
    if input.files.length > 0
      for file in input.files
        renderSpinner()

        formData = new FormData()
        formData.append("gallery[image]", file)

        promise = $.ajax "/properties/add_images",
        beforeSend: (xhr) ->
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]')
          .attr('content'))
        method: "POST",
        data: formData,
        cache: false,
        contentType: false,
        processData: false

        promise.then(() ->
          renderUploadedImage()
        )

  $("#property_images").change (e) ->
    readURL(this)

renderSpinner = () ->
  window.li = document.createElement("li")
  window.li.className = "list-inline-item"
  spinner = document.createElement("i")
  spinner.className = "fa fa-spinner fa-pulse fa-2x fa-fw"
  window.li.appendChild(spinner)
  document.getElementById("uploaded_property_images").appendChild(li);

renderUploadedImage = (li) ->
  window.li.removeChild(window.li.firstChild)
  div = document.createElement("div")
  div.style.backgroundImage = "url(" + e.target.result + ")"
  window.li.appendChild(div)
  return
