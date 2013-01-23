require 'spec_helper'

describe DigitalOcean::API, :vcr do
  let(:client_id) { CLIENT_ID }
  let(:api_key)   { API_KEY }

  describe '.new' do
    it 'should return an instance when called with the essential parameters' do
      client = DigitalOcean::API.new :client_id => client_id, :api_key => api_key
      client.should be_instance_of(DigitalOcean::API)
    end
  end

  describe '#droplets' do
    subject { DigitalOcean::API.new :client_id => client_id, :api_key => api_key }

    describe '#list' do
      let(:response) {
        subject.droplets.list
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end

      it 'should return a list of all droplets' do
        response.droplets.should have_at_least(1).item
      end
    end
  end
end
