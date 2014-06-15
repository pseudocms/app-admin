Admin.LoginController = Ember.Controller.extend
  reset: ->
    @setProperties
      username: ''
      password: ''
      errorMessage: ''

  actions:
    login: ->
      @set('errorMessage', null)

      op = $.ajax
        url: '/auth.json'
        type: 'POST'
        data: { user: @getProperties('username', 'password') }
        dataType: 'json'
        context: this

      op.always ->
        @set('password', null)

      op.done (response) ->
        @set('errorMessage', response.message)

        if response.token
          @set('token', response.token)
          transition = @get('attemptedTransition')
          if transition
            transition.retry()
            @set('attemptedTransition', null)
          else
            @transitionToRoute('/')

      op.fail (xhr, status, errorThrown) ->
        @set('errorMessage', 'There was an error')
