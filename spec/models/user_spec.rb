describe User do

  before(:each) { @user = User.new(email: 'user@example.com', picture_url: 'example.com/img.jpg', headline: 'Amazing graphic designer') }

  subject { @user }
  context 'email' do
    it { should respond_to(:email) }

    it "#email returns a string" do
      expect(@user.email).to match 'user@example.com'
    end
  end
  context 'pic' do
    it { should respond_to(:picture_url) }

    it "#picture_url returns a string" do
      expect(@user.picture_url).to match 'example.com/img.jpg'
    end
  end
  context 'headline' do
    it { should respond_to(:headline) }

    it "#headline returns a string" do
      expect(@user.headline).to match 'Amazing graphic designer'
    end
  end
end
