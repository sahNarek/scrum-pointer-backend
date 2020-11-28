module Mutations
  class CreateSession < Mutations::BaseMutation
    argument :name, String, required: false
    argument :voting_duration, Integer, required: false

    field :session, Types::SessionType, null: true
    field :errors, [String], null: true

    def resolve(name: nil, voting_duration: nil)
      unless context[:current_user].nil?
        user_id = context[:current_user].id
        user = User.find(user_id)
        session = Session.new(
          user_id: user_id,
          name: name || "Session #{user.sessions.count + 1}",
          voting_duration: voting_duration || 30
        )
        session.save!
        {
          session: session,
          errors: nil
        }
      else
        {
          errors: [I18n.t('no_user_signed_in')]
        }
      end
    end
  end
end