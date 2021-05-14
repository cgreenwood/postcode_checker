require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'allowed_lsoa?' do
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
      }.with_indifferent_access
    end

    let(:error_api_response) do
      { "status": 500,
        "result": {
          "lsoa": nil
        },
        "error": {
          "message": 'Error Message',
          "backtrace": 'Backtrace'
        } }.with_indifferent_access
    end

    it 'returns true when it includes an allowed LSOA' do
      expect(controller.allowed_lsoa?(api_response)).to be_truthy
    end

    it 'returns true when it includes an allowed LSOA' do
      modified_api_response = api_response
      modified_api_response["result"]["lsoa"] = 'Portsmouth 1234'
      expect(controller.allowed_lsoa?(modified_api_response)).to be_falsey
    end

    it 'returns true when it includes an allowed LSOA' do
      expect(controller.allowed_lsoa?(error_api_response)).to be_falsey
    end
  end

  describe 'allowed_postcode?' do
    it 'returns true when it includes an allowed postcode' do
      expect(controller.allowed_postcode?('SH241AA')).to be_truthy
    end

    it 'returns true when it includes an allowed postcode with space' do
      expect(controller.allowed_postcode?('SH24 1AA')).to be_truthy
    end

    it 'returns true when it includes an allowed postcode with spaces/cases' do
      expect(controller.allowed_postcode?('sh24 1aa')).to be_truthy
    end

    it 'returns false when it is not an allowed postcode' do
      expect(controller.allowed_postcode?('SE17QD')).to be_falsey
    end

    it 'returns false when it is not an allowed postcode but is similar' do
      expect(controller.allowed_postcode?('SH241XX')).to be_falsey
    end
  end
end
