module Mutations
  class CreateTicket < Mutations::BaseMutation
    argument :name, String, required: true
    argument :voting_session_id, ID, required: true

    field :ticket, Types::TicketType, null: true
    field :errors, [String], null: true

    def resolve(name:, voting_session_id:)
      ticket = Ticket.new(
        name: name, voting_session_id: voting_session_id, estimated: false
      )

      if ticket.valid?
        ticket.save!
        {
          ticket: ticket,
          errors: []
        }
        ScrumPointerBackendSchema.subscriptions.trigger(:ticket_added_to_voting_session, { voting_session_id: voting_session_id}, ticket)
        {
          ticket: ticket,
          errors: []
        }
      else
        begin
          ticket.validate!
        rescue ActiveRecord::RecordInvalid
          errors = ticket.errors.full_messages
        end
        {
          ticket: nil,
          errors: errors
        }
      end

    end
  end
end