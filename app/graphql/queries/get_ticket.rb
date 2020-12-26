module Queries
  class GetTicket < Queries::BaseQuery

    argument :id, ID, required: true
    type Types::TicketType, null: true

    def resolve(id:)
      Ticket.find(id)
    end

  end
end