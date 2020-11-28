class Mutations::UserSignUp < Mutations::BaseMutation
  argument :email, String, required:true
  argument :first_name, String, required:true
  argument :last_name, String, required:true
  argument :password, String, required:true
  argument :password_confirmation, String, required:true

  field :user, Types::UserType, null: true
  field :errors, [String], null: false


  def resolve(email:, first_name:, last_name:, password:,password_confirmation:)
    user = User.new(
      email:email, first_name:first_name, last_name:last_name,
      password: password, password_confirmation: password_confirmation
    )
    if user.valid?
      user.save!
      {
        user: user,
        errors: []
      }
    else
      begin
        user.validate!
      rescue ActiveRecord::RecordInvalid
        errors = user.errors.full_messages
      end
      {
        user: nil,
        errors: errors
      }
    end
  end
end