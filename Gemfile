source 'https://rubygems.org'

gem 'rails', '4.1.4'
# gem 'rails', github: 'rails/rails', branch: '4-1-stable'

## Platform Specific
platform :jruby do
  gem 'activerecord-jdbcpostgresql-adapter'
  gem 'jruby-openssl'
  gem 'trinidad', require: false
  gem 'therubyrhino', group: :assets
end

platform :rbx do
  gem 'pg'
  gem 'zeus'
  gem 'spring'
  gem 'rubysl', '~> 2.0'
end

platform :ruby do
  gem 'pg'
  gem 'zeus'
  gem 'spring'
end

## Rails
gem 'sass-rails', '~> 4.0.0.rc2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'tipsy-rails'
gem 'jbuilder', '~> 1.2'

## Assets
gem 'haml'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'simple_form', github: 'plataformatec/simple_form', branch: 'bootstrap-3'
gem 'opal'
gem 'opal-rails'
gem 'opal-jquery'


## Utility
gem 'friendly_id'
gem 'draper'
gem 'turnout'
gem 'high_voltage'
gem 'puma'
gem 'attr_extras'

## Security
gem 'bcrypt'
gem 'devise'
gem 'devise_security_extension'
gem 'easy_captcha'
gem 'pundit'
gem 'paranoia', github: 'liothen/paranoia', branch: 'rails4'
gem 'lumberjack'
gem 'rails_config'

## Forum

## API
gem 'msgpack'

## Content
gem 'kramdown'
gem 'coderay'
gem 'unread'
gem 'public_activity'
gem 'carrierwave'
gem 'acts-as-taggable-on'
gem 'mailboxer'

## Imageing
gem 'mini_magick'
gem 'gravtastic'

## Developer
#gem 'capistrano', '~> 3.0.1', group: :development
# gem 'capistrano-rails', '~> 3.0.1', group: :development
gem 'quiet_assets', group: :development
gem 'better_errors', group: :development
gem 'wirble'
gem 'map_by_method'
gem 'what_methods'
gem 'bullet'
gem 'mina'

## Testing
group :test do
  gem 'turn', :require => false
  gem 'cucumber-rails', :require => false
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'fabrication'

end

## Documentation
gem 'sdoc', group: :doc, require: false