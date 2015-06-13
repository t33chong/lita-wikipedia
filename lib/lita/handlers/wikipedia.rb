require "nokogiri"
require "sanitize"

module Lita
  module Handlers
    class Wikipedia < Handler

      API_URL = "https://en.wikipedia.org/w/api.php"

      route(/^(?:wiki|wikipedia)\s+(.*)/i, :wikipedia, command: true,
            help: { t("help.wikipedia_key") => t("help.wikipedia_value")})

      def wikipedia(response)
        term = response.matches[0][0]
        search = http.get(
          API_URL,
          search: term,
          action: "opensearch",
          format: "json"
        )
        titles = MultiJson.load(search.body)[1]
        return response.reply("No Wikipedia entry found for '#{term}'") if titles.empty?
        query = http.get(
          API_URL,
          titles: titles[0],
          action: "query",
          prop: "extracts|info",
          exintro: nil,
          inprop: "url",
          redirects: nil,
          format: "json"
        )
        page = MultiJson.load(query.body)["query"]["pages"].values[0]
        html = Nokogiri::HTML(page["extract"])
        extract = Sanitize.fragment(html.xpath("//p[1]")[0]).strip
        url = page["fullurl"]
        response.reply(extract)
        response.reply("Source: #{url}")
      end

    end

    Lita.register_handler(Wikipedia)
  end
end
