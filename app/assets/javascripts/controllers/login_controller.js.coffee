TOKEN_KEY = 'pseudocms.token'

Admin.LoginController = Ember.Controller.extend
  token: localStorage[TOKEN_KEY]
  tokenChanged: (->
    token = @get('token')
    if token
      localStorage[TOKEN_KEY] = token
    else
      delete localStorage[TOKEN_KEY]
  ).observes('token')

  reset: ->
    @setProperties
      email: ''
      password: ''
      errorMessage: ''

  signOut: ->
    @set('token', '')

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
