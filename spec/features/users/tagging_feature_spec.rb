describe 'Skill tagging' do
  let(:user) {create(:user)}
  before { visit user_path(user) }

  it 'creates a tag when supplied on sign up' do
    expect(user.skills.count).to eq 2
    expect(user.skills.first.name).to eq 'ruby'
    expect(page).to have_content 'ruby'
  end


end
