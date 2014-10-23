require 'open-uri'
require 'active_support/core_ext/hash'

class SteamRepo
  def self.get_user_summary(name)
    response = open("http://steamcommunity.com/id/#{name}/?xml=1").read
    response_hash = Hash.from_xml(response.gsub("\n", ""))
    if response_hash["response"]
      return {success?: false, error: response_hash["response"]["error"]}
    elsif response_hash["profile"]["privacyState"] == "public"
      return {success?: true, profile: response_hash}
    elsif response_hash["profile"]["privacyState"] != "public"
      return {success?: false, error: "The specified profile is private."}
    end
  end
end