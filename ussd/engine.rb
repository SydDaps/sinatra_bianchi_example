# frozen_string_literal: true

module USSD
  class Engine
    def self.start(params)
      Bianchi::USSD::Engine.start(params, provider: :africastalking) do
        menu :main, initial: true

        menu :transfer_money
        menu :transfer_money_all_networks
      end
    end
  end
end
