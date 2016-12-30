AfterStep do
  sleep (ENV['PAUSE'] || 0).to_i
end

# Capybara.default_driver = :selenium
# Capybara.javascript_driver = :selenium

# Capybara.default_max_wait_time = 3
# Capybara.app_host = 'http://localhost:3000'

