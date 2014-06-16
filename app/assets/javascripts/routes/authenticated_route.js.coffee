Admin.AuthenticatedRoute = Ember.Route.extend
  beforeModel: (transition) ->
    unless @controllerFor('login').get('token')
      @redirectToLogin(transition)

  redirectToLogin: (transition) ->
    controller = @controllerFor('login')
    controller.set('attemptedTransition', transition)
    @transitionTo('login')

  actions:
    logout: ->
      @controllerFor('login').signOut()
      window.location.reload()

    error: (reason, transition) ->
      @redirectToLogin(transition) if reason.status is 401
