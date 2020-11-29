class Mutations::UserSignIn < Mutations::BaseMutation
  argument :email, String, required: true
  argument :password, String, required: true

  field :token, String, null: true
  field :user, Types::UserType, null: true
  field :exp_time, String, null: true
  field :erros, String, null: true

  def resolve(email:, password:)
    payload = AuthHelper::user_sign_in email, password
    context[:session][:token] = payload[:token]
    #TODO remove after changing current_user logic to use request headers
    context[:current_user] = AuthHelper::find_user_by_token payload[:token]
    payload
  end
end