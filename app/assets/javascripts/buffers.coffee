# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:fetch', ->
  $('.content').fadeOut()
  # $('.lines').animate(opacity: 0)

# $(document).on 'page:restore', ->
#   $('.lines').fadeIn()

date_to_timestamp = (date)->
  Date.parse(date) / 1000

$(document).on "ready page:load", ->

  date_field = $("#datepicker")
  
  date_field.datepicker(dateFormat: "yy-mm-dd", changeYear: true, changeMonth: true, autoSize: true)
  date_field.on "change", ->
    Turbolinks.visit("?since=#{date_field.val()}")


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

