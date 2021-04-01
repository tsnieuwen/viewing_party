source 'https://rubygems.org'

git_source(:github) do |repo_name|
   repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.3'

gem 'rails', '5.2.4.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootsnap'
gem 'jbuilder', '~> 2.5'
gem 'redis-rails'


# Api
gem 'faraday'
gem 'figaro'
gem 'mimemagic', '~> 0.3.8'

# Authentication
gem 'bcrypt'

# Styling
gem 'bootstrap', '~> 4.0.0'
gem 'autoprefixer-rails'
gem 'jquery-rails'

# DB Visualization
gem 'active_designer', '~> 0.0.3'

group :development, :test do
  gem 'pry'
  gem 'travis'
  gem 'json'

end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop-rails'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'webmock'
  gem 'vcr'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
