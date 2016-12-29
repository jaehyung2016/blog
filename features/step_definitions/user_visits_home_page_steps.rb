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

