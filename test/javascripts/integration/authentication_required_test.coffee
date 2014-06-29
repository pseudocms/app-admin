module("Authentication Required")

test "visiting the home page requires login", ->
  visit('/')
  andThen ->
    ok find('.login-form').length, 'Transitions to login form'
