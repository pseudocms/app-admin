#= require spec_helper
#= require router

describe "Admin.Router", ->
  it "is an Ember.Router", ->
    assert.ok Admin.Router
    assert.ok Ember.Router.detect(Admin.Router)
