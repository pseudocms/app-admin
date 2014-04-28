#= require spec_helper
#= require store

describe "Admin.Store", ->
  beforeEach( ->
    Test.store = TestUtil.lookupStore()
  )

  it "works with latest Ember-Data revision", ->
    assert.equal Test.store.get('adapter'), '_ams'
