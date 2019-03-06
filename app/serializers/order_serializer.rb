class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total

  has_many :toys
end
