require "cgi"
require "json"
require "open-uri"

module Lita
  module Handlers
    class Wikipedia < Handler
      route(/^(?:wiki|wikipedia)\s+(.*)/i, :wikipedia, command: true,
            help: { t("help.wikipedia_key") => t("help.wikipedia_value")})

      def wikipedia(response)
        url = "http://en.wikipedia.org/w/api.php?action=query&prop=extracts|info&format=json&exintro=&explaintext=&inprop=url&titles=#{CGI.escape(response.matches.first)}&redirects="
        result = JSON.parse(open(URI.parse(URI.encode(url.strip))).read)
        page = result['query']['pages'].first[1]
        response.reply(page['extract'].split("\n").first)
        response.reply("Source: #{page['fullurl']}")
      end
    end

    Lita.register_handler(Wikipedia)
  end
end
