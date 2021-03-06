class ToySerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :price, :published, :created_at, :updated_at

  belongs_to :user
end
