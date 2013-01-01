class Raffler.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'


  initialize: ->
    @collection = new Raffler.Collections.Entries()
    @collection.fetch()

  index: ->
    view = new Raffler.Views.EntriesIndex(collection: @collection)
    $("#container").html(view.render().el)

  show: (id) ->
    @model = new Raffler.Models.Entry({id: id})
    @model.on 'sync', => @create_profile_view @model
    @model.fetch()

  create_profile_view: (model) ->
    view1 = new Raffler.Views.Profile(model: model)
    $("#profile_container").html(view1.render().el)