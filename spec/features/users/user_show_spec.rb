include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  let(:user) {create(:user)}
  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    visit user_path(user)
    expect(page).to have_content 'User'
    expect(page).to have_content user.email
  end

  it 'user profile has an image' do
    visit user_path(user)
    expect(page).to have_css '.user-photo'
    expect(page.find('.user-photo')['src']).to have_content 'example.com/img.jpg'
  end
  it 'user profile has an image' do
    visit user_path(user)
    expect(page).to have_css '.user-photo'
    expect(page.find('.user-photo')['src']).to have_content 'example.com/img.jpg'
  end

  it 'user profile has a headline' do
    visit user_path(user)
    expect(page).to have_css '.headline'
    expect(page).to have_content 'Amazing graphic designer'
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  # scenario "user cannot see another user's profile" do
  #   me = FactoryGirl.create(:user)
  #   other = FactoryGirl.create(:user, email: 'other@example.com')
  #   login_as(me, :scope => :user)
  #   Capybara.current_session.driver.header 'Referer', root_path
  #   visit user_path(other)
  #   expect(page).to have_content 'You need to sign in or sign up before continuing.'
  # end

end
