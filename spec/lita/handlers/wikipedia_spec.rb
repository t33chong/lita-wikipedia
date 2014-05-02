require "spec_helper"

describe Lita::Handlers::Wikipedia, lita_handler: true do
  it { routes_command("wikipedia").to(:wikipedia) }
  it { routes_command("wiki").to(:wikipedia) }

  describe "#wikipedia" do
    it "returns the 1st paragraph of the Wikipedia entry for a given query" do
      send_command "wikipedia ruby language"
      expect(replies.first).to match 'Ruby is a dynamic, reflective, object-oriented, general-purpose programming language. It was designed and developed in the mid-1990s by Yukihiro "Matz" Matsumoto in Japan.'
    end
  end
end
