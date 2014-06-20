FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please123"
    picture_url 'example.com/img.jpg'
    headline 'Amazing graphic designer'
    location 'London, UK'
    skill_names ['ruby', 'rails']
  end
end
