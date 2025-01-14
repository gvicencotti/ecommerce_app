FactoryBot.define do
  factory :order do
    association :user
    address { "123 Main St" }
    payment_method { "Credit Card" }
    total_price { 100.0 }
    status { "pending" }
  end
end
