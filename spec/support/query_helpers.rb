module QueryHelpers
  def signup_query(user:)
    <<~GQL
    mutation{
      userSignUp(input:{
        email: "#{user.email}"
        firstName: "#{user.first_name}"
        lastName: "#{user.last_name}"
        password: "#{user.password}"
        passwordConfirmation: "#{user.password_confirmation}"
      }){
        user{
          id
          firstName
          lastName
          email
        }
        errors
      }
    }
    GQL
  end

  module_function :signup_query
end