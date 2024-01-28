# frozen_string_literal: true

module USSD
  module TransferMoneyAllNetworksMenu
    class Page4 < Bianchi::USSD::Page
      def request
        render_and_await message
      end

      def response
        session.store.set('amount', Float(session_input_body))
        redirect_to_next_page
      rescue ArgumentError
        render_and_await("invalid amount \n#{message}")
      end

      private

      def message
        'Enter Amount:'
      end
    end
  end
end
