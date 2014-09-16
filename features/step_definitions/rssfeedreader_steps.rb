def create_visitor
	@visitor ||= { :first_name => "Debashis", :last_name => "Giri", :email => "example@example.com",
	:password => "T!atros123", :password_confirmation => "T!atros123" }
end

def sign_up
	delete_user
	visit '/users/sign_up'
	fill_in "user_first_name", :with => @visitor[:first_name]
	fill_in "user_last_name", :with => @visitor[:last_name]
	fill_in "user_email", :with => @visitor[:email]
	fill_in "user_password", :with => @visitor[:password]
	fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
	click_button "Sign up"
	find_user
end

def delete_user
	@user ||= User.where(:email => @visitor[:email]).first
	@user.destroy unless @user.nil?
end

def find_user
	@user ||= User.where(:email => @visitor[:email]).first
end


When /^I sign up with valid user data$/ do
	create_visitor
	sign_up
end

Given(/^I am on the home page$/) do
  visit '/'
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

When(/^I follow "(.*?)"$/) do |link|
  click_link link
end

Then(/^I wait for "(\d+)" seconds$/) do |secs|
  sleep secs.to_i
end

Then(/^I press "(.*?)"$/) do |name|
  click_button name
end

When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field.gsub(' ', '_'), :with => value)
end
