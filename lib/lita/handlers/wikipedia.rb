module Lita
  module Handlers
    class Wikipedia < Handler
      route(/^(?:wiki|wikipedia)\s+(.*)/i, :wikipedia, command: true, help: {
        t("help.wikipedia_key") => t("help.wikipedia_value")})

      def wikipedia(response)
      end
    end

    Lita.register_handler(Wikipedia)
  end
end
