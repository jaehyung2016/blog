Given(/^I am reading an article$/) do
  create_articles(1)
  visit post_path(1)
  @current_path = current_path
end

When(/^I sign up for the blog with email "([^"]*)"$/) do |email|
  click_link "Login"
  expect(page).to have_css("#signup_tab_link")
  click_link "signup_tab_link"
  expect(page).to have_css("#new_user")
  fill_in "user_email", with: email
  fill_in "user_password", with: "password"
  fill_in "user_password_confirmation", with: "password"
  fill_in "user_first_name", with: "John"
  fill_in "user_last_name", with: "Doe"
  click_button "Sign up"
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I am still on the same web page$/) do
  # puts @current_path
  expect(current_path).to eq @current_path
end

