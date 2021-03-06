module QueryHelpers
  def sign_up(user:)
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

  def sign_in(user:)
    <<~GQL
    mutation{
      userSignIn(input:{
        email: "#{user.email}",
        password: "#{user.password}"
      }){
        user{
          id
          firstName
          lastName
          email
        }
        token
        expTime
        errors
      }
    }
    GQL
  end

  def get_user(id:)
    <<~GQL
    query{
      user(id:"#{id}"){
        id
        firstName
        lastName
        email
        votingSessions {
          id
          name
        }
      }
    }
    GQL
  end

  def create_voting_session(user:)
    <<~GQL
    mutation{
      userSignIn(input:{
        email: "#{user.email}",
        password: "#{user.password}"
      }){
        user{
          id
          firstName
          lastName
          email
        }
        token
        expTime
        errors
      }
      createVotingSession(input:{}){
        votingSession{
          id
          name
          userId
          votingDuration
        }
        errors
      }
    }
    GQL
  end

  module_function :sign_up, :sign_in, :create_voting_session, :get_user
end