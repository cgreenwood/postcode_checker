Feature: Check Postcode
  As the product owner
  I want to check a variety of postcodes
  To see if they are in our service area

Scenario:
  Given I am on the homepage
  And that the postcode.io site is available
  When I fill in "postcode_text" with "SE1 7QD"
  And I click on "Check"
  Then I can see the "success" message "Good news! It appears as though you're in our service area."

Scenario:
  Given I am on the homepage
  And that the postcode.io site is available
  When I fill in "postcode_text" with "SE17QD"
  And I click on "Check"
  Then I can see the "success" message "Good news! It appears as though you're in our service area."

Scenario:
  Given I am on the homepage
  And that the postcode.io site is available
  When I fill in "postcode_text" with "10 Downing Street"
  And I click on "Check"
  Then I can see the "danger" message "Sorry we couldn't recognise your postcode. Please try again."

Scenario:
  Given I am on the homepage
  And that the postcode.io site is available
  When I fill in "postcode_text" with "10118"
  And I click on "Check"
  Then I can see the "danger" message "Sorry we couldn't recognise your postcode. Please try again."

Scenario:
  Given I am on the homepage
  And that the postcode.io site is available but returning "404"
  When I fill in "postcode_text" with "SH24 1XX"
  And I click on "Check"
  Then I can see the "danger" message "Sorry it doesn't look like we can reach you."
