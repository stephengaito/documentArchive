Then(/^the result should contain default content class$/) do
  puts last_response.body;
  expect(last_response).to have_xpath("//a[@class='content']");
end

