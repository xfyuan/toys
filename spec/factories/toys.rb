FactoryBot.define do
  factory :toy do
    sequence(:title) { |n| "Toy title#{n}" }
    price { "%.2f" % (rand() * 100) }
    published { false }
    user
  end
end
