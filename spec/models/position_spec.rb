describe Position do

  before(:each) do
    @user = User.new(email: 'user@example.com',
                     picture_url: 'example.com/img.jpg',
                     headline: 'Amazing graphic designer',
                     location: 'London, UK')
    @position = Position.new(company: 'VoiceCandy', title: 'CEO')
    @user.positions << @position
    @position.user = @user
  end

  subject { @position }
  context 'company' do
    it { should respond_to(:company) }

    it "#company returns a string" do
      expect(@position.company).to match 'VoiceCandy'
    end
  end
  context 'title' do
    it { should respond_to(:title) }

    it "#title returns a string" do
      expect(@position.title).to match 'CEO'
    end
  end
  context 'user' do
    it { should belong_to(:user) }

    it 'belongs to user' do
      expect(@position).to respond_to(:user)
    end
    it 'belongs to correct user' do
      expect(@position.user).to eq @user
    end

  end
end
