module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Queries::GetUser
  end
end
