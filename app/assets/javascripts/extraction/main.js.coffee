groups = []
window.root = JSON.parse root
init = ->
  $("a").click (e)->
    event.preventDefault()

  Ui.clusterize root, 2, groups
  Ui.bindGroups groups

  $("#level").change ->
    Ui.unbindGroups groups
    $(".selected_highlight").removeClass "selected_highlight"
    groups = []
    Ui.clusterize root, $(this).val(), groups
    Ui.bindGroups groups

  $(".extraction-center img").click ->
    $(".extraction-center .selected").removeClass "selected"
    $(this).addClass "selected"

  $(".extraction-reset-button").click ->
    $(".selected_highlight").removeClass "selected_highlight"

  $(".extraction-button").click ->
    elements = $(".selected_highlight").size()
    if $(".selected_highlight").size() is 0
      alert "Please choose some elements before"
      return false
    if $("#extraction-form:visible").size() is 0
      $.jGrowl "<form id='extraction-form' action='#'><input type='text' placeholder='Enter label here...'></input><input type='submit' id='extraction-label-button'></input></form>", 
        header: "Choose a label"
        sticky: true
        afterOpen: ->
          $('#extraction-form').submit (event)->
            event.preventDefault()
            label = $('#extraction-form input[type="text"]').val()
            if label
              $('.jGrowl-notification').trigger('jGrowl.beforeClose')
              centroids = $(".selected_highlight").map (index, element)->
                return $(element).attr("centroid")
              centroids = _.uniq centroids
              centroids = _.map centroids, (centroid)->
                return groups[centroid]
              console.log centroids
              Ui.result.labels[label] = centroids
              $(".selected_highlight").removeClass "selected_highlight"
            return false
  $(".extraction-submit-button").click ->
    if not (jQuery.isEmptyObject Ui.result.labels)
      Ui.save()
    else
      alert("You have not labeled any items yet.")

$ init

window.groups = groups