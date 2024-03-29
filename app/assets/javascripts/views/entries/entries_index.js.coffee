class Raffler.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']

  events:
    'submit #new_entry': 'createEntry'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendEntry, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendEntry)
    this

  appendEntry: (event) ->
    view = new Raffler.Views.Entry(model: event)
    $("#entries").append(view.render().el)

  createEntry: (event) ->
    event.preventDefault()
    attributes = name: $('#new_entry_name').val(), username: $('#new_entry_username').val()
    @collection.create attributes,
      wait: true
      success: -> $('#new_entry')[0].reset()
      error: @handleError

  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
