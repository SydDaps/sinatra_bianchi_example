# frozen_string_literal: true

module USSD
  module TransferMoneyAllNetworksMenu
    class Page5 < Bianchi::USSD::Page
      def request
        render_and_await message
      end

      def response
        case session_input_body
        when '1'
          # send_payment_request
          render_and_end 'Wait for a prompt to approve transaction'
        when '2'
          render_and_end 'Transaction cancelled successfully'
        else
          render_and_await "Invalid selection \n#{message}"
        end
      end

      private

      def message
        session_data = session.store.all
        transfer_details = mocked_transfer_details_request

        <<~MSG
          Transfer to #{transfer_details[:name]} #{session_data['recipients_number']} for
          GHS #{session_data['amount']}. Fee is GHS #{transfer_details[:fee]}.

          1.proceed
          2.cancel
        MSG
      end

      def mocked_transfer_details_request
        {
          name: 'Sydney Dapilah',
          fee: '20'
        }
      end
    end
  end
end
