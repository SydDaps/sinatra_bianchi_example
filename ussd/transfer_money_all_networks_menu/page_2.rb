# frozen_string_literal: true

module USSD
  module TransferMoneyAllNetworksMenu
    class Page2 < Bianchi::USSD::Page
      def request
        render_and_await message
      end

      def response
        recipients_number = session_input_body

        render_and_await("invalid number \n#{message}") unless valid_mobile_number? recipients_number

        session.store.set('recipients_number', recipients_number)

        redirect_to_next_page
      end

      private

      def message
        <<~MSG
          Enter mobile number:
        MSG
      end

      def valid_mobile_number?(number)
        Phonelib.valid_for_country? number, :gh
      end
    end
  end
end
