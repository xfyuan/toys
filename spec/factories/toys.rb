FactoryBot.define do
  factory :toy do
    sequence(:title) { |n| "Toy title#{n}" }
    price { "%.2f" % (rand() * 100) }
    published { false }
    quantity { 5 }
    user
  end
end
