Platform.create name: 'Facebook', make: 'facebook'
Platform.create name: 'Google+', make: 'google'
Platform.create name: 'Twitter', make: 'twitter'

User.create!({
  email: 'user@example.com',
  password: '123456',
  password_confirmation: '123456',
  active: true
})


