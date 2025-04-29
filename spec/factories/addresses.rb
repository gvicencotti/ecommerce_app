FactoryBot.define do
  factory :address do
    cep { "38400-100" }
    street { "Rua das Flores" }
    neighborhood { "Centro" }
    city { "Uberlândia" }
    state { "MG" }
    association :user
  end
end
