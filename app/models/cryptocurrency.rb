class Cryptocurrency < ApplicationRecord
  validates :name, :price, presence: true
end
