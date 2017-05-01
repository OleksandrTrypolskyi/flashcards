$(document).ready ->
  $(document).on 'click', '#link_for_check', ->
    $('#section_for_check').fadeToggle()
    $('#link_for_check').toggle()
    $('#card_original_text').focus()
