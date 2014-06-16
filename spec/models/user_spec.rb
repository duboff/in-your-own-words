describe User do

  before(:each) { @user = User.new(email: 'user@example.com', picture_url: 'example.com/img.jpg') }

  subject { @user }
  context 'email' do
    it { should respond_to(:email) }

    it "#email returns a string" do
      expect(@user.email).to match 'user@example.com'
    end
  end
  context 'pic' do
    it { should respond_to(:picture_url) }

    it "#email returns a string" do
      expect(@user.picture_url).to match 'example.com/img.jpg'
    end
  end
end
