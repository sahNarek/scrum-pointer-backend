module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Queries::GetUser
    field :current_user, resolver: Queries::GetCurrentUser
  end
end
