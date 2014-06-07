Admin.AuthenticatedRoute = Ember.Route.extend
  beforeModel: (transition) ->
    unless @controllerFor('login').get('token')
      @redirectToLogin(transition)

  redirectToLogin: (transition) ->
    controller = @controllerFor('login')
    controller.set('attemptedTransition', transition)
    @transitionTo('login')
