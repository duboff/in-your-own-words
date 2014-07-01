source 'https://rubygems.org'
ruby '2.1.2'
gem 'rails', '4.1.0'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'devise'
gem 'haml-rails'
gem 'pg'
gem 'simple_form'
gem 'thin'
gem 'omniauth'
gem 'omniauth-linkedin-oauth2'
gem 'font-awesome-sass'
# gem 'linkedin-oauth2'
gem 'carrierwave'
gem "fog"
gem 'heroku_secrets', github: 'alexpeattie/heroku_secrets'
gem "searchkick"
gem 'pluggable_js'
gem 'wicked'
# gem "elasticsearch", git: "git://github.com/elasticsearch/elasticsearch-ruby.git"
# gem "elasticsearch-model", git: "git://github.com/elasticsearch/elasticsearch-rails.git"
# gem "elasticsearch-rails", git: "git://github.com/elasticsearch/elasticsearch-rails.git"


group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'mailcatcher'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'capybara-email'
  gem 'shoulda-matchers'
end

group :production do
  gem 'rails_12factor'

  gem 'mandrill'
end
