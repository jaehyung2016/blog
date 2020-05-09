AfterStep do
  sleep (ENV['PAUSE'] || 0).to_i
end

After("@javascript") do |scenario|
  puts "javascript tag"
end

After do |scenario|
  puts Capybara::current_driver
  if scenario.failed?
    byebug
  end
end
