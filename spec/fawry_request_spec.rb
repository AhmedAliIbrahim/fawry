# frozen_string_literal: true

RSpec.describe Fawry::FawryRequest do
  context 'charge request' do
    describe '.new' do
      it 'builds the correct charge request' do
        fawry_request = described_class.new('charge', params)
        expect(fawry_request.class.included_modules.include?(Fawry::Requests::ChargeRequest)).to be true
        expect(fawry_request.action).to eq('charge')
        expect(fawry_request.request[:path]).to eq('charge')
        expect(fawry_request.request[:body].keys).to eq(fawry_params.keys)
      end
    end

    describe '#fire' do
      it 'fires a charge request to fawry' do
        stub_request(:post, Fawry::Connection::FAWRY_BASE_URL + 'charge')
          .with(body: fawry_params)
          .to_return(status: 200, body: fawry_api_response)

        described_class.new('charge', params).fire

        expect(WebMock).to have_requested(:post, Fawry::Connection::FAWRY_BASE_URL + 'charge')
          .with(body: fawry_params)
      end
    end
  end
end