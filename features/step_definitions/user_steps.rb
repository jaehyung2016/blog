
Given(/^there are (#{CAPTURE_A_NUMBER}) articles$/) do |count|
  create_articles(count)
end

When(/^I visit the home page$/) do
  visit root_path
end

Then(/^I should see index page with "([^"]*)"$/) do |text|
  expect(page).to have_blog_title
  expect(page).to have_selector "main", text: text
end

Then(/^I should not see any articles$/) do
  expect(page).to have_no_selector "article"
end

Then(/^I should see index page with (#{CAPTURE_A_NUMBER}) articles$/) do |count|
  expect(page).to have_articles(count)
end

Then(/^I should not see pagination links$/) do
  expect(page).not_to have_selector("main .pagination")
end

Then(/^I should see pagiation links with (#{CAPTURE_A_NUMBER}) pages$/) do |count|
  within("main .pagination") do
    expect(page).to have_link("Last", href: /\/page\/#{count}$/)
  end
end

Given(/^I am reading an article$/) do
  create_articles(1)
  visit post_path(1)
  @current_path = current_path
end

When(/^I sign up for the blog with email "([^"]*)"$/) do |email|
  open_login_modal_box
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

When(/^I log in with email "([^"]*)"$/) do |email|
  open_login_modal_box
  expect(page).to have_field("login_user_email")
  fill_in "login_user_email", with: email
  fill_in "login_user_password", with: "password"
  click_button "Login"
end

Then(/^I should see "([^"]*)" in the menu bar$/) do |text|
  within "#menu_bar" do
    expect(page).to have_text(text)
  end
end

