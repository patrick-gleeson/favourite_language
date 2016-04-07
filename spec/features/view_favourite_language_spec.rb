require 'rails_helper'

RSpec.feature 'View favourite language', type: :feature do
  let(:response_body) do
    [{ language: 'Ruby' },
     { language: 'Java' },
     { language: 'Ruby' }]
  end

  let(:username) { 'patrick-gleeson' }

  scenario 'I visit the home page' do
    visit '/'
    expect(page).to have_text(
      'Use the search box above to enter any GitHub username ')
  end

  scenario 'I search successfully', js: true do
    stub_request(:get, "https://api.github.com/users/#{username}/repos")
      .to_return(status: 200, body: response_body.to_json)

    visit '/'
    fill_in 'username', with: username
    click_button 'search'

    expect(page).to have_text("#{username}'s favourite language is Ruby")
  end

  scenario 'I search unsuccessfully', js: true do
    stub_request(:get, "https://api.github.com/users/#{username}/repos")
      .to_return(status: 404)

    visit '/'
    fill_in 'username', with: username
    click_button 'search'

    expect(page).to have_text(
      "I'm sorry; I couldn't find out #{username}'s favourite language")
  end
end
