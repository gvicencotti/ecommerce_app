FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    role { "regular" }

    trait :admin do
      role { 'admin' }
    end

    trait :vendor do
      role { 'vendor' }
    end

    trait :regular do
      role { 'regular' }
    end
  end
end
