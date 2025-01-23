FactoryBot.define do
  factory :address do
    association :user
    cep { "12345678" }
    street { "Main St" }
    neighborhood { "Downtown" }
    city { "Anytown" }
    state { "SP" }
  end
end
