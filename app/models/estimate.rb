class Estimate < ApplicationRecord
  belongs_to :ticket, inverse_of: :estimates
  belongs_to :voter, inverse_of: :estimates
end
