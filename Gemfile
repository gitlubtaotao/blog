source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
gem 'bcrypt'
gem 'faker',                   '1.4.2'
gem 'carrierwave',             '0.10.0'
gem 'mini_magick',             '3.8.0'
gem 'fog',                     '1.36.0'
gem 'will_paginate',           '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'redis', '~>3.2' # optional
gem "paperclip", "~> 5.0.0"
gem 'mongoid', '~> 4.0.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem  'wechat'
gem 'weui-rails'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano', '3.3.3'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  # gem 'i18n-debug'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # gem 'capistrano-sidekiq'
  gem 'capistrano-passenger'
  # Use sqlite3 as the database for Active Record
end
group :production, :development, :master do
  gem 'mysql2', '~> 0.3.18'
  gem 'passenger'
  # online bug collect
  gem 'rollbar', '~> 2.8'

  # wechat like process bar
  gem 'nprogress-rails'
  
  # 简单强大的调试工具
  gem 'pry-rails'
  gem 'pry-nav'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'colorize' # 'what color you like in log'.yellow
  gem 'wisper', '2.0.0.rc1'
  
  # gem 'smart_sms', path: 'https://github.com/EverAnts/smart_sms.git'
  # gem 'redcarpet', git: 'git://github.com/EverAnts/smart_sms.git
  # gem 'redis', '~>3.2'
  # gem "fakeredis"


 

end

