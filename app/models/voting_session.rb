class VotingSession < ApplicationRecord
  belongs_to :user
  has_many :tickets, inverse_of: :voting_session
  has_many :voters, inverse_of: :voting_session
end
