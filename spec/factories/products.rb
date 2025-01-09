FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 10..100.0) }
    stock { rand (1..100) }
    association :category
    association :user
  end
end
