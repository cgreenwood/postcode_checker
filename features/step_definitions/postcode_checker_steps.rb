Given('that the postcode.io site is available') do
  api_response = {
    "status": 200,
    "result": {
      "postcode": "SE1 7QD",
      "lsoa": "Southwark 034A"
    }
  }
  stub_request(:get, /postcodes.io/)
    .to_return(status: 200, body: api_response.to_json, headers: {})
end

Given('that the postcode.io site is available but returning {string}') do |http_status|
  api_response =     {
    "status": 404,
    "error": "Postcode not found"
  }
  stub_request(:get, /postcodes.io/)
    .to_return(status: http_status, body: api_response.to_json, headers: {})
end
