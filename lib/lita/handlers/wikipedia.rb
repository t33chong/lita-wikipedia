require "cgi"
require "json"
require "open-uri"

def disambiguate(term)
  url = "http://en.wikipedia.org/w/api.php?action=query&prop=extracts|info|links&format=json&exintro=&explaintext=&inprop=url&titles=#{CGI.escape(term)}&redirects="
  result = JSON.parse(open(URI.parse(URI.encode(url.strip))).read)
  page = result['query']['pages'].first[1]
  puts page['extract'].class  #debug
  extract = page['extract'].split("\n").first
  if /(?:may|can) refer to/.match(extract) != nil
    links = page['links'].map {
      |x| x['title'] if not x['title'].downcase.include? 'disambiguation'}
    links = links.select {|x| x != nil}
    link = links.sample
    puts "link: #{link}"
    return disambiguate(link)
  end
  url = page['fullurl']
  [extract, url]
end

puts disambiguate('12th man')

module Lita
  module Handlers
    class Wikipedia < Handler
      route(/^(?:wiki|wikipedia)\s+(.*)/i, :wikipedia, command: true,
            help: { t("help.wikipedia_key") => t("help.wikipedia_value")})

      def wikipedia(response)
        extract, url = disambiguate(response.matches.first.first)
        response.reply(extract)
        response.reply("Source: #{url}")
      end
    end

    Lita.register_handler(Wikipedia)
  end
end
