# frozen_string_literal: true

module USSD
  module TransferMoneyMenu
    class Page1 < Bianchi::USSD::Page
      def request
        render_and_await message
      end

      def response
        option_menus = {
          '1' => 'transfer_money_all_networks',
          '2' => 'transfer_money_non_momo_user',
          '3' => 'transfer_money_bank_account',
          '5' => 'transfer_money_all_networks',
          '0' => 'main'
        }

        next_menu = option_menus[session_input_body]

        render_and_await("invalid input \n#{message}") unless next_menu.present?

        if session_input_body == '1'
          session.store.set('selected_network', 'momo')
          redirect_to_transfer_money_all_networks_menu_page_2
        else
          send("redirect_to_#{next_menu}_menu_page_1")
        end
      end

      private

      def message
        <<~MSG
          Transfer Money
          1) MoMo User
          2) Non Momo User
          3) Send With Care
          4) Favorite
          5) Other Network
          6) Bank Account
          0) Back
        MSG
      end
    end
  end
end
