require 'rails_helper'
require_relative '../../lib/postcode_api'

RSpec.describe PostcodeApi do
  let(:valid_postcode) { 'SE17QD' }

  let(:valid_postcode_with_space) { 'SE1 7QD' }

  let(:invalid_postcode) { 'SH24 1XX' }

  let(:api_response) do
    {
      "status": 200,
      "result": {
        "postcode": "SE1 7QD",
        "quality": 1,
        "eastings": 531_513,
        "northings": 179_395,
        "country": "England",
        "nhs_ha": "London",
        "longitude": -0.106793,
        "latitude": 51.498204,
        "european_electoral_region": "London",
        "primary_care_trust": "Southwark",
        "region": "London",
        "lsoa": "Southwark 034A"
      }
    }
  end

  let(:error_api_response) do
    {
      "status": 404,
      "error": "Postcode not found"
    }
  end

  context 'when the site is available and postcodes exist' do
    before(:each) do
      stub_request(:get, /postcodes.io/)
        .to_return(status: 200, body: api_response.to_json, headers: {})
    end

    it 'returns information for a correct postcode without spaces' do
      response = PostcodeApi.check_postcode(valid_postcode)
      expect(response["status"]).to eq(200)
      expect(response["result"]["lsoa"]).to be_present
    end

    it 'returns information for a correct postcode with spaces' do
      response = PostcodeApi.check_postcode(valid_postcode_with_space)
      expect(response["status"]).to eq(200)
      expect(response["result"]["lsoa"]).to be_present
    end
  end

  context 'when the site is available but the postcode isnt recognised' do
    before(:each) do
      stub_request(:get, /postcodes.io/)
        .to_return(status: 404, body: error_api_response.to_json, headers: {})
    end

    it 'errors correctly for an invalid postcode' do
      response = PostcodeApi.check_postcode(invalid_postcode)
      expect(response["status"]).to_not eq(200)
      expect(response["result"]).to be_present
      expect(response["result"]["lsoa"]).to be_nil
    end
  end

  context 'when the site isnt available' do
    before(:each) do
      stub_request(:get, /postcodes.io/)
        .to_return(status: 500, body: '', headers: {})
    end

    it 'errors correctly for an invalid postcode' do
      response = PostcodeApi.check_postcode(valid_postcode_with_space)
      expect(response["status"]).to_not eq(200)
      expect(response["result"]).to be_present
      expect(response["result"]["lsoa"]).to be_nil
    end
  end
end
