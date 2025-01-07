FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { 'password123' }

    trait :admin do
      admin { true }
    end

    trait :regular do
      role { 'regular' }
    end
  end
end
