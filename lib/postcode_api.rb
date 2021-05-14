require 'uri'

class PostcodeApi
  def self.check_postcode(postcode)
    cleaned_postcode = postcode.gsub(/\s+/, "")
    url = "http://postcodes.io/postcodes/#{cleaned_postcode}"
    request = RestClient.get(url)
    raise 'Received a response other than 200' if request.code != 200

    JSON.parse(request.body)
  rescue StandardError => e
    { "status": 500,
      "result": { "lsoa": nil },
      "error": { "message": e.message, "backtrace": e.backtrace } }.with_indifferent_access
  end
end
