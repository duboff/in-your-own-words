describe Skill do

  before(:each) { @skill = Skill.new(name: 'ruby') }

  subject { @skill }
  context 'name' do
    it { should respond_to(:name) }

    it "#name returns a string" do
      expect(@skill.name).to match 'ruby'
    end
  end
end
