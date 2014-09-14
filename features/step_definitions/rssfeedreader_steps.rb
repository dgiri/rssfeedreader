Then(/^I wait for "(\d+)" seconds$/) do |secs|
  sleep secs.to_i
end

And /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
	fill_in(field, :with => value)
end