
Given(/^there are (#{CAPTURE_A_NUMBER}) articles$/) do |count|
  create_articles(count)
end

When(/^I visit the home page$/) do
  visit root_path
end

Then(/^I should see index page indicating there are no articles$/) do
  expect(page).to have_blog_title
  expect(page).to have_no_articles_message
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

When(/^I sign up for the blog$/) do
  sign_up_with "john.doe@example.com"
end

Then("I should see a notice message for successful sign-up") do
  expect(page).to have_content("You have successfully signed up.")
end

When(/^I try to sign up with an existing email$/) do
  sign_up_with "john.doe@example.net"
end

Then("I should see an error message for sign-up failure") do
  expect(page).to have_content("Email john.doe@example.net is already registered.")
end

Then(/^I should be still on the same web page$/) do
  # puts @current_path
  expect(current_path).to eq @current_path
end

When(/^I log in$/) do
  log_in_with "john.doe@example.net"
end

When("I try to log in with wrong information") do
  log_in_with "john.doe@example.com"
end

When("I log out") do
  log_out
end

Then(/^I should see my name in the menu bar$/) do
  within "#menu_bar" do
    expect(page).to have_text("John")
  end
end

Then(/^I should not see my name in the menu bar$/) do
  within "#menu_bar" do
    expect(page).not_to have_text("John")
  end
end

Then("I should see an error message for log-in failure") do
  expect(page).to have_text("Invalid email/password")
end

Then("I should be redirected to home page") do
  expect(current_path).to eq root_path
end

Given("I am logged in") do
  log_in_with "john.doe@example.net"
end

When("I open My Account page") do
  open_my_account_page
end

Then("I should see current account information") do
  expect(page).to have_field("user_email", with: "john.doe@example.net")
end

When("I update account information") do
  fill_in("user_email", with: "john.doe@example.com")
  click_button "Save"
end

Then("I should see updated account information") do
  expect(page).to have_field("user_email", with: "john.doe@example.com")
end

Then("I should see a notice message for successful update of account information") do
  expect(page).to have_text("Your account information was successfully updated.")
end

When("I delete my account") do
  click_link "Delete my account"
  accept_confirm
end

Then("my account should not exist any more") do
  pending
end

And("my articles should not exist any more") do
  pending
end

And("I should be logged out") do
  pending
end

