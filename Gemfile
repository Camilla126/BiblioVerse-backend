source "https://rubygems.org"

gem "rails", "~> 8.1.2"
# gem "propshaft" # Removido: pipeline de assets
# gem "puma", ">= 5.0" # Mantido para servidor
# gem "importmap-rails" # Removido: frontend
# gem "turbo-rails" # Removido: frontend
# gem "stimulus-rails" # Removido: frontend
# gem "jbuilder" # Removido: não usar builder de views
# gem "redis", ">= 4.0.1" # Comente/descomente conforme uso
gem "bcrypt", "~> 3.1.7" # Comente/descomente conforme uso

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "firebase", "~> 0.2.0"
gem "dotenv-rails"
gem 'google-cloud-firestore'

gem 'pg'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", require: false

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

# Gemfile
gem "puma", "~> 7.2"

gem "rack-cors"

gem "jwt"