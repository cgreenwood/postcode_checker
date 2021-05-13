require 'rails_helper'
require_relative '../../lib/postcode_api'

RSpec.describe PostcodeApi, type: :helper do
  describe 'check_postcode_format' do
    let(:valid_postcode) { 'SE17QD' }

    let(:valid_postcode_with_space) { 'SE1 7QD' }

    let(:invalid_postcode) { 'SH24 1XX' }

    let(:invalid_input) { '10 Downing Street' }

    let(:us_zipcode) { '10118' }

    it 'returns true for a valid postcode' do
      expect(helper.check_postcode_format(valid_postcode)).to be_truthy
    end

    it 'returns true for a valid postcode with a space' do
      expect(helper.check_postcode_format(valid_postcode_with_space)).to be_truthy
    end

    it 'returns true for an unrecognised postcode' do
      expect(helper.check_postcode_format(invalid_postcode)).to be_truthy
    end

    it 'returns false for an invalid input - address' do
      expect(helper.check_postcode_format(invalid_input)).to be_falsey
    end

    it 'returns false for an invalid input - US Zipcode' do
      expect(helper.check_postcode_format(us_zipcode)).to be_falsey
    end

    it 'returns false for an invalid input - blank' do
      expect(helper.check_postcode_format(nil)).to be_falsey
      expect(helper.check_postcode_format('')).to be_falsey
    end
  end
end
