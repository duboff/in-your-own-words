class User < ActiveRecord::Base

  has_and_belongs_to_many :skills
  # attr_accessor :client
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
    :omniauth_providers => [:linkedin]

  def self.connect_to_linkedin(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else

        self.client = LinkedIn::Client.new(Rails.application.secrets[:linkedin_key], Rails.application.secrets[:linkedin_token],auth.access_token)
        puts '*' * 50
        p auth.public_methods
        p client
        puts '*' * 50
        user = User.create(name:auth.info.name,
                           picture_url:auth.info.image,
                           headline:auth.info.description,
                           location:auth.info.location.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           skill_names:authraw_info['skills'].values.map {|value| value.skill.name}.join(' '),
                           password:Devise.friendly_token[0,20]
                           )
      end

    end
  end

  def skill_names=(skill_names)
    skill_names.split(' ').uniq.each do |skill_name|
      skill = Skill.find_or_create_by(name: skill_name.downcase)
      skills << skill
    end
  end

  def skill_names
    skills.map(&:name)
  end

  # def profile
  #   self.client.profile
  # end

end
