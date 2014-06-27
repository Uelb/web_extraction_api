groups = []
window.root = JSON.parse root
init = ->
  $("a:not('.root_link')").click (event)->
    event.preventDefault()

  Ui.clusterize root, 2, groups
  Ui.bindGroups groups

  $("#level").change ->
    Ui.unbindGroups groups
    $(".selected_highlight").removeClass "selected_highlight"
    $(".selected_highlight_image").removeClass "selected_highlight_image"
    groups = []
    Ui.clusterize root, $(this).val(), groups
    Ui.bindGroups groups

  $(".extraction-center img").click ->
    $(".extraction-center .selected").removeClass "selected"
    $(this).addClass "selected"

  $(".extraction-reset-button").click ->
    $(".selected_highlight").removeClass "selected_highlight"
    $(".selected_highlight_image").removeClass "selected_highlight_image"
  $(".extraction-button").click ->
    elements = $(".selected_highlight, .selected_highlight_image")
    if elements.size() is 0
      alert "Please choose some elements before"
      return false
    if $("#extraction-form:visible").size() is 0
      $("div.jGrowl").jGrowl("close");
      $.jGrowl "<form id='extraction-form' action='#'><input type='text' placeholder='Enter label here...'></input><br/><label for='container'>Container ?</label><input type='checkbox' name='container'></input><br/><input type='submit' id='extraction-label-button'></input></form>", 
        header: "Choose a label"
        sticky: true
        afterOpen: ->
          $("#extraction-form input[type='text']").focus()
          $('#extraction-form').submit (event)->
            event.preventDefault()
            label = $('#extraction-form input[type="text"]').val()
            if label
              $('.jGrowl-notification').trigger('jGrowl.beforeClose')
              centroids = $(".selected_highlight, .selected_highlight_image").map (index, element)->
                return $(element).attr("centroid")
              centroids = underscore.uniq centroids
              centroids = underscore.map centroids, (centroid)->
                return groups[centroid]
              console.log centroids
              Ui.result.labels[label] = 
                centroids: centroids
                container: $("#extraction-form input[type='checkbox']").is(":checked")
              $("#extraction-form input[type='checkbox']").prop('checked', false);
              $(".selected_highlight").removeClass "selected_highlight"
              $(".selected_highlight_image").removeClass "selected_highlight_image"
              $("#config-panel").append("<div><input type='text' name='#{label}' value='#{label}'></input><img class='delete' src='/assets/delete.png'/></div>")
            return false
  $(".extraction-submit-button").click ->
    if not (jQuery.isEmptyObject Ui.result.labels)
      $('.loader').removeClass('hidden')
      Ui.save()
    else
      alert("You have not labeled any items yet.")

  $(".config").click ->
    $("div.jGrowl").jGrowl("close");
    $.jGrowl $('#config-panel').html(),
      header: "Configuration panel"
      sticky: true
      afterOpen: ->
        # $("div.jGrowl inputt[type='text']").focusin ->
          # Highlight maybe in pink the element of the label which is focused in.
        $("div.jGrowl input[type='text']").focusout ->
          new_label = $(this).val()
          old_label = $(this).attr("name")
          $("#config-panel input[name='#{old_label}'], div.jGrowl input[name='#{old_label}").attr("name", new_label).attr("value", new_label)
          Ui.result.labels[new_label] = Ui.result.labels[old_label]
          delete Ui.result.labels[old_label]
        $('div.jGrowl .delete').click ->
          label = $(this).parent().find('input').val()
          delete Ui.result.labels[label]
          $("#config-panel input[name='#{label}'], div.jGrowl input[name='#{label}").parent().remove()

$ init

window.groups = groups