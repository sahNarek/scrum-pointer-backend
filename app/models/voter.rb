class Voter < ApplicationRecord
  has_many :estimates, inverse_of: :voter
  belongs_to :voting_session, inverse_of: :voters
end
