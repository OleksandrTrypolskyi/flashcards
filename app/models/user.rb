class User < ApplicationRecord
  has_many :cards, inverse_of: :user
end
