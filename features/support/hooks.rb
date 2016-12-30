After do |scenario|
  puts Capybara::current_driver
  if scenario.failed?
    sleep(1) if Capybara::current_driver == :selenium
    # save_and_open_page
  end
end
