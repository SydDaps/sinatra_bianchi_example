# frozen_string_literal: true

module USSD
  module MainMenu
    class Page1 < Bianchi::USSD::Page
      def request
        render_and_await message
      end

      def response
        option_menus = {
          '1' => 'transfer_money',
          '2' => 'momo_pay_n_bill_pay',
          '3' => 'airtime_n_bundles',
          '4' => 'allow_cash_out',
          '5' => 'financial_services',
          '6' => 'my_wallet'
        }

        next_menu = option_menus[session_input_body]

        render_and_await("invalid input \n#{message}") unless next_menu.present?

        send("redirect_to_#{next_menu}_menu_page_1")
      end

      private

      def message
        <<~MSG
          Menu
          1) Transfer Money
          2) MomoPay & pay Bill
          3) Airtime & Bundles
          4) Allow Cash Out
          5) Financial Services
          6) My Wallet
        MSG
      end
    end
  end
end
