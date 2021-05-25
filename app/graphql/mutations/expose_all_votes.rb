module Mutations
  class ExposeAllVotes < Mutations::BaseMutation
    argument :ticket_id, ID, required: true
    argument :revoting, Boolean, required: false

    field :ticket, Types::TicketType, null: true
    field :errors, [String], null: true

    def resolve(ticket_id: ,revoting:false)
      begin
        ticket = Ticket.find(ticket_id)
        if(revoting)
          Estimate.where(ticket_id: ticket_id).update_all(:final_estimate => false)
        end
        Estimate.where(ticket_id: ticket_id).update_all(:final_estimate => true)
        {
          ticket: ticket,
          errors: []
        }
      rescue ActiveRecord::RecordNotFound
        {
          ticket: nil,
          errors: ticket.errors.full_messages
        }
      end
      
    end
  end
end