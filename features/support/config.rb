require 'capybara/poltergeist'

if ENV['IN_BROWSER']
  Capybara.default_driver = :selenium
  AfterStep do
    sleep (ENV['PAUSE'] || 0).to_i
  end
else
  Capybara.javascript_driver = :poltergeist
end

# Capybara.app_host = 'http://localhost:3000'

