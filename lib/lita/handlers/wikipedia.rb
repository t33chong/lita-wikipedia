require "wikipedia"

Wiki = Wikipedia
Wikipedia = nil

module Lita
  module Handlers
    class Wikipedia < Handler
      route(/^(?:wiki|wikipedia)\s+(.*)/i, :wikipedia, command: true,
            help: { t("help.wikipedia_key") => t("help.wikipedia_value")})

      def wikipedia(response)
        page = Wiki.find(response.matches.first)
        response.reply(page.text.split("\n").first)
        response.reply(page.fullurl)
      end
    end

    Lita.register_handler(Wikipedia)
  end
end
