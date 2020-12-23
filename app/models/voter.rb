class Voter < ApplicationRecord
  has_many :estimates, inverse_of: :voters
end
