# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @Answer
  @add_atwho = ->
    $('#answer_comment').atwho
      at: '@'
      displayTpl:"<li class='mention-item' data-value='(${name},${image})'>${name} ${image}</li>",
      callbacks: remoteFilter: (query, callback) ->
        if (query.length < 1)
          return false
        else
          $.getJSON '/mentions', { q: query }, (data) ->
            callback data

jQuery ->
  Answer.add_atwho()