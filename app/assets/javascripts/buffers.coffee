# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).on 'page:fetch', ->
#   $('.lines').fadeOut()
#   $('.lines').animate(opacity: 0)

# $(document).on 'page:restore', ->
#   $('.lines').fadeIn()

$(document).on "ready", ->
  # search_field = $('#search-field')
  # search_field.focus()

  follow = (classname)->
    # console.log "followed #{classname}"
    event.preventDefault()
    elem = $(classname)[0]
    elem.click() if elem 

  $(document).on 'keydown', ->
    switch event.keyIdentifier
      when 'Right'
        follow(".next_page")

      when 'Left'
        follow(".prev_page")

      when 'Home'
        follow(".first_page")

      when 'End'
        follow(".last_page")

      when 'PageDown'
        follow(".fast_next_page")
        
      when 'PageUp'
        follow(".fast_prev_page")

      # when 'Enter'
      # when 'U+001B'
        # ESC

    # if !search_field.is(':focus')
    #   search_field.focus()

