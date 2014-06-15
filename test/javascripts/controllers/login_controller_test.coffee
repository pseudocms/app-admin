moduleFor("controller:login", "Login Controller:")

test "#reset clears email, password and errorMessage properties", ->
  controller = @subject()
  controller.setProperties
    email: 'username'
    password: 'password'
    errorMessage: 'errorMessage'

  controller.reset()

  equal controller.get('email'), '', 'Email is blank'
  equal controller.get('password'), '', 'Password is blank'
  equal controller.get('errorMessage'), '', 'Error message is blank'

test "login action set tokens on successful login", ->
  controller = @subject()
  controller.setProperties
    email: 'gooduser'
    password: 'goodpassword'

  server.respondWith('POST', '/auth.json', [
    200,
    { 'Content-Type': 'application/json' },
    JSON.stringify(access_token: '12345')
  ])

  sinon.stub(controller, 'transitionToRoute')
  controller.send('login')
  server.respond()

  equal controller.get('token'), '12345', 'Token is set on successful login'

test "login action sets error message when login fails", ->
  controller = @subject()
  controller.setProperties
    email: 'baduser'
    password: 'badpass'

  server.respondWith('POST', '/auth.json', [
    200,
    { 'Content-Type': 'application/json' },
    JSON.stringify(error_description: 'error happened!')
  ])

  controller.send('login')
  server.respond()

  equal controller.get('errorMessage'), 'error happened!', 'Error message is set'

test "login action sets error message when an error occurs", ->
  controller = @subject()
  server.respondWith('POST', '/auth.json', [
    400,
    { 'Content-Type': 'application/json' },
    ''
  ])

  controller.send('login')
  server.respond()

  equal controller.get('errorMessage'), 'There was an error', 'Error message is set'
