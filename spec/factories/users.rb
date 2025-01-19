FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    role { "regular" }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip_code }
    country { Faker::Address.country }

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
