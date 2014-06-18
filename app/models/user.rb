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
        user = User.create(name:auth.info.name,
                           picture_url:auth.info.image,
                           headline:auth.info.description,
                           location:auth.info.location.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           skill_names:auth.extra.raw_info.skills.values.last.map {|value| value.skill.name},
                           password:Devise.friendly_token[0,20]
                           )
      end

    end
  end

  def skill_names=(skill_names)
    p skill_names
    skill_names.each do |skill_name|
      skill = Skill.find_or_create_by(name: skill_name.downcase)
      skills << skill
    end
  end

  def skill_names
    skills.map(&:name)
  end

end
