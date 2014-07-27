groups = []
jq = $ if $ == jQuery
init = ->
  window.root = JSON.parse root
  jq("a:not('.root_link')").click (event)->
    event.preventDefault()

  Ui.clusterize root, 2, groups
  Ui.bindGroups groups

  jq("#level").change ->
    Ui.unbindGroups groups
    jq(".selected_highlight").removeClass "selected_highlight"
    jq(".selected_highlight_image").removeClass "selected_highlight_image"
    groups = []
    Ui.clusterize root, jq(this).val(), groups
    Ui.bindGroups groups

  jq(".extraction-center img").click ->
    jq(".extraction-center .selected").removeClass "selected"
    jq(this).addClass "selected"

  jq(".extraction-reset-button").click ->
    jq(".selected_highlight").removeClass "selected_highlight"
    jq(".selected_highlight_image").removeClass "selected_highlight_image"
  jq(".extraction-button").click ->
    elements = jq(".selected_highlight, .selected_highlight_image")
    if elements.size() is 0
      alert "Please choose some elements before"
      return false
    if jq("#extraction-form:visible").size() is 0
      jq("div.jGrowl").jGrowl("close");
      jq.jGrowl "<form id='extraction-form' action='#'><input type='text' placeholder='Enter label here...'></input><br/><label for='container'>Container ?</label><input type='checkbox' name='container'></input><br/><input type='submit' id='extraction-label-button'></input></form>", 
        header: "Choose a label"
        sticky: true
        afterOpen: ->
          jq("#extraction-form input[type='text']").focus()
          jq('#extraction-form').submit (event)->
            event.preventDefault()
            label = jq('#extraction-form input[type="text"]').val()
            if label
              jq('.jGrowl-notification').trigger('jGrowl.beforeClose')
              centroids = jq(".selected_highlight, .selected_highlight_image").map (index, element)->
                return jq(element).attr("centroid")
              centroids = underscore.uniq centroids
              centroids = underscore.map centroids, (centroid)->
                return groups[centroid]
              console.log centroids
              Ui.result.labels[label] = 
                centroids: centroids
                container: jq("#extraction-form input[type='checkbox']").is(":checked")
              jq("#extraction-form input[type='checkbox']").prop('checked', false);
              jq(".selected_highlight").removeClass "selected_highlight"
              jq(".selected_highlight_image").removeClass "selected_highlight_image"
              jq("#config-panel").append("<div><input type='text' name='#{label}' value='#{label}'></input><img class='delete' src='/assets/delete.png'/></div>")
            return false
  jq(".extraction-submit-button").click ->
    if not (jq.isEmptyObject Ui.result.labels)
      jq('.loader').removeClass('hidden')
      Ui.save()
    else
      alert("You have not labeled any items yet.")

  jq(".config").click ->
    jq("div.jGrowl").jGrowl("close");
    jq.jGrowl jq('#config-panel').html(),
      header: "Configuration panel"
      sticky: true
      afterOpen: ->
        jq("div.jGrowl input[type='text']").focusin ->
          label = jq(this).attr("name")
          centroids = Ui.result.labels[label].centroids
          underscore.each centroids, (centroid) ->
            Ui.highlight Ui.getIdSelector(centroid), "temp_highlight", "temp_img_highlight"
        jq("div.jGrowl input[type='text']").focusout ->
          jq(".temp_highlight").removeClass("temp_highlight")
          jq(".temp_img_highlight").removeClass("temp_img_highlight")
          new_label = jq(this).val()
          old_label = jq(this).attr("name")
          if(new_label != old_label)
            jq("#config-panel input[name='#{old_label}'], div.jGrowl input[name='#{old_label}").attr("name", new_label).attr("value", new_label)
            Ui.result.labels[new_label] = Ui.result.labels[old_label]
            delete Ui.result.labels[old_label]
        jq('div.jGrowl .delete').click ->
          label = jq(this).parent().find('input').val()
          delete Ui.result.labels[label]
          jq("#config-panel input[name='#{label}'], div.jGrowl input[name='#{label}").parent().remove()

jq init

window.groups = groups