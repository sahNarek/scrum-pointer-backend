class Mutations::UserSignIn < Mutations::BaseMutation
  argument :email, String, required: true
  argument :password, String, required: true

  field :token, String, null: true
  field :user, Types::UserType, null: true
  field :exp_time, String, null: true
  field :errors, [String], null: true

  def resolve(email:, password:)
    payload = AuthHelper::user_sign_in email, password
    context[:current_user] = AuthHelper::find_user_by_token payload[:token]
    payload
  end
end