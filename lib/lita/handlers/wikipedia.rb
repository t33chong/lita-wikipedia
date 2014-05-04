require "json"
require "open-uri"

def disambiguate(term)
  url = "http://en.wikipedia.org/w/api.php?action=query&prop=extracts|info|links|pageprops&format=json&exintro=&explaintext=&inprop=url&ppprop=disambiguation&titles=#{term}&redirects="
  result = JSON.parse(open(URI.parse(URI.encode(url.strip))).read)
  page = result['query']['pages'].first[1]
  if not page.has_key? 'content'
    return ["No Wikipedia entry found for '#{term}'.", nil]
  end
  extract = page['extract'].split("\n").first
  if page.fetch('pageprops', {}).has_key? 'disambiguation'
    links = page['links'].map {
      |x| x['title'] if not x['title'].downcase.include? 'disambiguation'}
    links = links.select {|x| x != nil}
    return disambiguate(links.sample)
  end
  url = page['fullurl']
  [extract, url]
end

module Lita
  module Handlers
    class Wikipedia < Handler
      route(/^(?:wiki|wikipedia)\s+(.*)/i, :wikipedia, command: true,
            help: { t("help.wikipedia_key") => t("help.wikipedia_value")})

      def wikipedia(response)
        extract, url = disambiguate(response.matches.first.first)
        response.reply(extract)
        if url != nil
          response.reply("Source: #{url}")
        end
      end
    end

    Lita.register_handler(Wikipedia)
  end
end
