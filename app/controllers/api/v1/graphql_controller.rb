module Api
  module V1
    class GraphqlController < ApplicationController
      # If accessing from outside this domain, nullify the session
      # This allows for outside API access while preventing CSRF attacks,
      # but you'll have to authenticate your user separately
      # protect_from_forgery with: :null_session
    
      def execute
        variables = prepare_variables(params[:variables])
        query = params[:query]
        operation_name = params[:operationName]
        result = ScrumPointerBackendSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
        render json: result
      rescue => e
        raise e unless Rails.env.development?
        handle_error_in_development e
      end
    
      private

      def context
        {
          session: session,
          current_user: AuthHelper::find_user_by_token(token),
          current_voter: AuthHelper::find_voter_by_token(voter_token)
        }
      end

      def voter_token
        request&.headers["voterToken"]
      end

      def token
        request&.headers["authorization"]
      end
      # Handle variables in form data, JSON body, or a blank value

      def prepare_variables(variables_param)
        case variables_param
        when String
          if variables_param.present?
            JSON.parse(variables_param) || {}
          else
            {}
          end
        when Hash
          variables_param
        when ActionController::Parameters
          variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
        when nil
          {}
        else
          raise ArgumentError, "Unexpected parameter: #{variables_param}"
        end
      end
    
      def handle_error_in_development(e)
        logger.error e.message
        logger.error e.backtrace.join("\n")
    
        render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
      end
    end
    
  end
end
