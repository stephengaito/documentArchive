
When(/^we get json from '\/testJson'$/) do
  get('/testJson', {}, { 'HTTP_ACCEPT' => "application/json" });
end

Then(/^testJson\.json is downloaded$/) do
  expect(last_response.header['Content-type']).to match /application\/json/
end

