require "json"
require "nokogiri"
require "open-uri"
require "sanitize"

module Lita
  module Handlers
    class Wikipedia < Handler
      route(/^(?:wiki|wikipedia)\s+(.*)/i, :wikipedia, command: true,
            help: { t("help.wikipedia_key") => t("help.wikipedia_value")})

      def wikipedia(response)
        term = response.matches.first.first
        search_url = "http://en.wikipedia.org/w/api.php?action=opensearch&search=#{term}&format=json"
        search_result = JSON.parse(open(URI.parse(URI.encode(search_url.strip))).read)
        titles = search_result[1]
        if titles.empty?
          response.reply("No Wikipedia entry found for '#{term}'")
        else
          query_url = "http://en.wikipedia.org/w/api.php?action=query&prop=extracts|info&format=json&exintro=&inprop=url&titles=#{titles.first}&redirects="
          query_result = JSON.parse(open(URI.parse(URI.encode(query_url.strip))).read)
          page = query_result['query']['pages'].first[1]
          html = Nokogiri::HTML(page['extract'])
          extract = Sanitize.fragment(html.xpath('//p[1]').first).strip
          url = page['fullurl']
          response.reply(extract)
          response.reply("Source: #{url}")
        end
      end

    end

    Lita.register_handler(Wikipedia)
  end
end
