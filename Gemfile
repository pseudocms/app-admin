source 'https://rubygems.org'
ruby '2.1.1'

gem 'rails', '4.1.0'
gem 'unicorn-rails'

gem 'ember-rails'
gem 'ember-source'
gem 'font-awesome-rails'

group :development do
  gem 'spring'
end

group :development, :test do
  gem 'ember-konacha-rails', github: 'kristianmandrup/ember-konacha-rails'
  gem "konacha"
  gem "poltergeist"
  gem "selenium-webdriver"
  gem "guard"
  gem "guard-konacha"
end

group :development, :test, :assets do
  gem 'sass-rails', '~> 4.0.3'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'phantomjs'
end
