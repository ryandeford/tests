FactoryGirl.define do
  factory :user do
    name 'somename'
    email 'some@email.com'
    password 'somepass'
    password_confirmation 'somepass'
  end
end
