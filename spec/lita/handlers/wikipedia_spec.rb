require "spec_helper"

describe Lita::Handlers::Wikipedia, lita_handler: true do
  it { routes_command("wikipedia ruby language").to(:wikipedia) }
  it { routes_command("wiki ruby language").to(:wikipedia) }

  describe "#wikipedia" do
    it "returns the 1st paragraph & link to the Wikipedia entry for a query" do
      send_command "wikipedia ruby language"
      expect(replies[0]).to match 'Ruby is a dynamic, reflective, object-oriented, general-purpose programming language. It was designed and developed in the mid-1990s by Yukihiro "Matz" Matsumoto in Japan.'
      expect(replies[1]).to match 'Source: http://en.wikipedia.org/wiki/Ruby_(programming_language)'
    end

    it "responds with a random matching article when disambiguation occurs" do
      send_command "wiki 12th man"
      responses = [
        "Source: http://en.wikipedia.org/wiki/The_Twelfth_Man",
        "Source: http://en.wikipedia.org/wiki/The_12th_Man_(album)",
        "Source: http://en.wikipedia.org/wiki/12th_man_(football)",
        "Source: http://en.wikipedia.org/wiki/Glossary_of_cricket_terms"
      ]
      expect(responses).to include(replies[1])
    end

    it "returns an error message if no article is found" do
      send_command "wiki asdfasdfa"
      expect(replies.first).to match "No Wikipedia entry found for 'asdfasdfa'."
    end
  end

  describe "#disambiguate" do
    it "resolves disambiguation by returning a random matching article" do
      extract, url = disambiguate('12th man')
      urls = [
        "http://en.wikipedia.org/wiki/The_Twelfth_Man",
        "http://en.wikipedia.org/wiki/The_12th_Man_(album)",
        "http://en.wikipedia.org/wiki/12th_man_(football)",
        "http://en.wikipedia.org/wiki/Glossary_of_cricket_terms"
      ]
      expect(urls).to include(url)
    end
  end
end
