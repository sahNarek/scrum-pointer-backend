class Ticket < ApplicationRecord
  belongs_to :voting_session, inverse_of: :tickets
  has_many :estimates, inverse_of: :ticket
end
