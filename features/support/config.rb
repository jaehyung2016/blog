
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome

# Capybara.default_driver = :selenium

# Capybara.default_max_wait_time = 3
# Capybara.app_host = 'http://localhost:3000'

