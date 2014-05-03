require "spec_helper"

describe Lita::Handlers::Wikipedia, lita_handler: true do
  it { routes_command("wikipedia ruby language").to(:wikipedia) }
  it { routes_command("wiki ruby language").to(:wikipedia) }

  describe "#wikipedia" do
    it "returns the 1st paragraph & link to the Wikipedia entry for a query" do
      send_command "wikipedia ruby language"
      expect(replies[0]).to match 'Ruby is a dynamic, reflective, object-oriented, general-purpose programming language. It was designed and developed in the mid-1990s by Yukihiro "Matz" Matsumoto in Japan.'
      expect(replies[1]).to match 'http://en.wikipedia.org/wiki/Ruby_(programming_language)'
    end
  end
end
