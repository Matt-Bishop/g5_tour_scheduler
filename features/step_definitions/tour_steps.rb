def my_info(view)
  if view == "page"
    page.should have_content("Email: homer@simpson.com")
    page.should have_content("First name: Homer")
    page.should have_content("Last name: Simpson")
    page.should have_content("Phone number: 5415415411")
    page.should have_content("Pool")
    page.should have_content("Time Machine")
    page.should have_content("Rec Room")
    page.should have_content("May 12, 2016")
    page.should_not have_content("On Site Doctor")
    page.should_not have_content("Movie Theater")
  else
    current_email.default_part_body.to_s.should include "homer@simpson.com"
    current_email.default_part_body.to_s.should include "Homer"
    current_email.default_part_body.to_s.should include "Simpson"
    current_email.default_part_body.to_s.should include "5415415411"
    current_email.default_part_body.to_s.should include "Time Machine"
    current_email.default_part_body.to_s.should include "Pool"
    current_email.default_part_body.to_s.should include "Rec Room"
    current_email.default_part_body.to_s.should include "May 12, 2016"
    current_email.default_part_body.to_s.should_not include "On Site Doctor"
    current_email.default_part_body.to_s.should_not include "Movie Theater"
  end
end  

Given /^I visit the site$/ do
  visit root_path
end

When /^I enter an email$/ do
  fill_in "Email", with: "homer@simpson.com"
  click_button "Submit"
end

Then /^I should be given notification that an email was sent$/ do
  page.should have_content("Please check your email. We've sent an activation link to homer@simpson.com.")
end

When /^I visit the link provided in the email$/ do
  @user = TourRequest.find_by_email("homer@simpson.com")
  visit edit_tour_request_path(id: @user.id , t: @user.token)
end

Then /^I should be presented with a contact information form$/ do
  page.should have_content("First name")
  page.should have_content("Last name")
  page.should have_content("Phone number")
end

When /^I fill out the contact information$/ do
  fill_in "First name", with: "Homer"
  fill_in "Last name", with: "Simpson"
  fill_in "Phone number", with: "5415415411"
  click_button "Continue"
end

Then /^I should be presented with a tour info form$/ do
  page.should have_content("Amenities")
  page.should have_content("Additional questions")
  page.should have_content("Preferred tour date")
end

When /^I fill out the tour info form$/ do
  check "Pool"
  check "Time Machine"
  check "Rec Room"
  select "2016", from: "tour_request_preferred_tour_date_1i"
  select "May", from: "tour_request_preferred_tour_date_2i"
  select "12", from: "tour_request_preferred_tour_date_3i"
  fill_in "Additional questions", with: "Do you have beer?"
  click_button "Continue"
end

Then /^I should see a success message$/ do
  page.should have_content("Congratulations, you have scheduled a tour!")
end

Then /^the tour request info should be there but not the ip address$/ do
  my_info("email")
  current_email.default_part_body.to_s.should_not include "IP address:"
end

Then /^the tour request info should be there with the ip address$/ do
  my_info("email")
  current_email.default_part_body.to_s.should include "IP address:"
end


Then /^I should see a ratings form$/ do
  page.should have_content("Rate your tour experience")
end

Then /^I should see my info$/ do
  my_info("page")
end

When /^I fill out the ratings form$/ do
  select "5", from: "tour_request_rating"
  click_button "Continue"
end

Then /^I should see a thank you message$/ do
  page.should have_content("Thank you for rating your tour")
end

When /^I don't enter an email$/ do
  click_button "Submit"
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

When /^I enter a bad email$/ do
  fill_in "Email", with: "john@jon"
  click_button "Submit"
end

When /^I click continue$/ do
  click_button "Continue"
end

Then /^I should be at the same edit form$/ do
  user = TourRequest.last
  URI.parse(current_url).path.should == "/tour_requests/#{user.id}"
  page.should_not have_content("Amenities")
  page.should have_content("First name can't be blank")
  page.should have_content("Last name can't be blank")
  page.should have_content("Phone number can't be blank")
end

When /^I enter the information$/ do
  fill_in "First name", with: "Homer"
  fill_in "Last name", with: "Simpson"
  fill_in "Phone number", with: "5415415411"
  click_button "Continue"
end

Then /^I should be allowed to move on$/ do
  page.should have_content("Amenities")
  page.should_not have_content("First name")
end
