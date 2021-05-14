Given('I am on the homepage') do
  visit root_path
end

When('I fill in {string} with {string}') do |form_element_id, input|
  fill_in form_element_id, with: input
end

When('I click on {string}') do |button_label|
  click_on button_label
end

Then('I can see the {string} message {string}') do |message_type, message_text|
  page.should have_selector ".alert.alert-#{message_type}", text: message_text
end

Then('I cannot see the {string} message {string}') do |message_type, message_text|
  page.should_not have_selector ".alert.alert-#{message_type}", text: message_text
end
