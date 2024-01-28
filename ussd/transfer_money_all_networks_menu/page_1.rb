# frozen_string_literal: true

module USSD
  module TransferMoneyAllNetworksMenu
    class Page1 < Bianchi::USSD::Page
      def request
        render_and_await message
      end

      def response
        return redirect_to_transfer_money_menu_page_1 if session_input_body == '0'

        selected_network = option_menus[session_input_body]

        return render_and_await("invalid input \n#{message}") unless next_menu.present?

        session.store.set('selected_network', selected_network)

        redirect_to_next_page
      end

      private

      def message
        <<~MSG
          Transfer Money To Other Network
          1) AirtelTigo
          2) Vodafone
          3) E-Zwitch
          4) G-Money
          5) Zeepay
          6) GhanaPay
          0) Back
        MSG
      end
    end
  end
end
