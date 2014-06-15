Admin.LoginController = Ember.Controller.extend
  reset: ->
    @setProperties
      email: ''
      password: ''
      errorMessage: ''

  # rename token and errorMessage for CMSAPI
  actions:
    login: ->
      @set('errorMessage', null)

      op = $.ajax
        url: '/auth.json'
        type: 'POST'
        data: { user: @getProperties('email', 'password') }
        dataType: 'json'
        context: this

      op.always ->
        @set('password', null)

      op.done (response) ->
        @set('errorMessage', response.error_description)

        if response.access_token
          @set('token', response.access_token)
          transition = @get('attemptedTransition')
          if transition
            transition.retry()
            @set('attemptedTransition', null)
          else
            @transitionToRoute('/')

      op.fail (xhr, status, errorThrown) ->
        @set('errorMessage', 'There was an error')
