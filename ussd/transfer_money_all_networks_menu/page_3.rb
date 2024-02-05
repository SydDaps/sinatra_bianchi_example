# frozen_string_literal: true

module USSD
  module TransferMoneyAllNetworksMenu
    class Page3 < Bianchi::USSD::Page
      def request
        render_and_await message
      end

      def response
        render_and_await 'numbers do not match re enter' unless recipients_number_matches? session_input_body

        redirect_to_next_page
      end

      private

      def message
        <<~MSG
          Confirm number:
        MSG
      end

      def recipients_number_matches?(number)
        session.store.get('recipients_number') == number
      end
    end
  end
end
