module Api
  module V1
    class GraphqlChannel < ApplicationCable::Channel
      def subscribed
        @subscription_ids = []
      end
    
      def execute(data)
        query = data["query"]
        variables = ensure_hash(data["variables"])
        operation_name = data["operationName"]
        result = ScrumPointerBackendSchema.execute({
          query: query,
          context: context,
          variables: variables,
          operation_name: operation_name
        })
    
        payload = {
          result: result.to_h,
          more: result.subscription?,
        }
    
        # Track the subscription here so we can remove it
        # on unsubscribe.
        if result.context[:subscription_id]
          @subscription_ids << result.context[:subscription_id]
        end
    
        transmit(payload)
      end
    
      def unsubscribed
        @subscription_ids.each { |sid|
          ScrumPointerBackendSchema.subscriptions.delete_subscription(sid)
        }
      end
    
      private
    
      def context
        {
          channel: self,
          session: session,
          current_user: AuthHelper::find_user_by_token(token)
        }
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

