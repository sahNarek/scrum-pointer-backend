FactoryBot.define do
  factory :user do
    sequence(:first_name) { Faker::Name.unique.name }
    sequence(:last_name) { Faker::Name.unique.name }
    sequence(:email) { Faker::Internet.unique.email }
    sequence(:password) { "123456" }
    sequence(:password_confirmation) { "123456" }
  end
end