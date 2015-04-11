require "spec_helper"

describe Lita::Handlers::Wikipedia, lita_handler: true do
  it { is_expected.to route_command("wikipedia ruby language").to(:wikipedia) }
  it { is_expected.to route_command("wiki ruby language").to(:wikipedia) }

  describe "#wikipedia" do
    it "returns the 1st paragraph & link to the Wikipedia entry for a query" do
      send_command "wikipedia ruby language"
      expect(replies[0]).to match 'Ruby is a dynamic, reflective, object-oriented, general-purpose programming language. It was designed and developed in the mid-1990s by Yukihiro "Matz" Matsumoto in Japan.'
      expect(replies[1]).to match 'Source: http://en.wikipedia.org/wiki/Ruby_(programming_language)'
    end

    it "handles commas in queries correctly" do
      send_command "wikipedia indio, ca"
      expect(replies[1]).to match 'Source: http://en.wikipedia.org/wiki/Indio,_California'
    end

    it "responds with the disambiguation page on appropriate queries" do
      send_command "wiki 12th man"
      expect(replies[0]).to match 'The phrase 12th Man or Twelfth Man can refer to:'
      expect(replies[1]).to match 'Source: http://en.wikipedia.org/wiki/12th_Man'
    end

    it "returns an error message if no article is found" do
      send_command "wiki asdfasdfa"
      expect(replies.first).to match "No Wikipedia entry found for 'asdfasdfa'"
    end
  end
end
