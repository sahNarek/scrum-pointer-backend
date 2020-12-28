Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  namespace "api" do
    namespace "v1" do
      if Rails.env.development?
        mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute'
      end
      post "/graphql", to: "graphql#execute"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
