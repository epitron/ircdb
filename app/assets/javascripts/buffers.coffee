# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:fetch', ->
  $('#content').fadeOut 'slow'

$(document).on 'page:restore', ->
  $('#content').fadeIn 'slow'

$(document).on "ready page:load", ->
  # search_field = $('#search-field')
  # search_field.focus()

  $('body').keydown ->
    console.log "Key: #{event.keyIdentifier}"
    # console.log e.keyCode
    # if e.keyCode == 27
    #   clear_search()
    switch event.keyIdentifier
      when 'Right'
        console.log 'Next'
        event.preventDefault()
        $(".next_page")[0].click()

      when 'Left'
        console.log 'Prev'
        event.preventDefault()
        $(".prev_page")[0].click()

      when 'Home'
        console.log 'Home'
        event.preventDefault()
        $(".first_page")[0].click()

      when 'End'
        console.log 'End'
        event.preventDefault()
        $(".last_page")[0].click()

      # when 'PageDown'
      # when 'PageUp'
      # when 'Enter'

      when 'U+001B'
        # ESC
        event.preventDefault()
        console.log 'esc'
        # clear_search()
      else
        return
      # Quit when this doesn't handle the key event.


    # if !search_field.is(':focus')
    #   search_field.focus()

