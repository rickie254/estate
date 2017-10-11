$(document).on 'turbolinks:load', ->
  console.log "foi"
  readURL = (input) ->
    console.log "foi"
    if input.files.length > 0
      console.log "foi"
      reader = new FileReader()

      for file in input.files
        reader.onload = (e) ->
          li = document.createElement("li");
          li.style.backgroundImage = "url(" + e.target.result + ")"
          document.getElementById("property_images").appendChild(li);
        reader.readAsDataURL(file)

  $("#house_images").change (e) ->
    readURL(this)

  return
