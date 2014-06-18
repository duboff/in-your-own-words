describe Skill do

  before(:each) do
    @user = User.new(email: 'user@example.com',
                     picture_url: 'example.com/img.jpg',
                     headline: 'Amazing graphic designer',
                     location: 'London, UK')
    @skill = Skill.new(name: 'ruby')
    @user.skills << @skill
    @skill.users << @user
  end

  subject { @skill }
  context 'name' do
    it { should respond_to(:name) }

    it "#name returns a string" do
      expect(@skill.name).to match 'ruby'
    end
  end
  context 'user' do
    it { should have_and_belong_to_many(:users) }

    it 'belongs to user' do
      expect(@skill).to respond_to(:users)
    end
    it 'belongs to correct user' do
      expect(@skill.users.first.id).to eq @user.id
    end

  end
end
