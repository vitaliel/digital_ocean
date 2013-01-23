require 'spec_helper'

describe DigitalOcean::API, :vcr do
  subject { DigitalOcean::API.new :client_id => client_id, :api_key => api_key }
  let(:client_id) { CLIENT_ID }
  let(:api_key)   { API_KEY }

  describe '.new' do
    it 'should return an instance when called with the essential parameters' do
      client = DigitalOcean::API.new :client_id => client_id, :api_key => api_key
      client.should be_instance_of(DigitalOcean::API)
    end
  end

  describe '#droplets' do

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

    # describe '#show' do
    #   let(:id) { 83102 }
    #   let(:response) {
    #     subject.droplets.show id
    #   }

    #   it 'should be successful' do
    #     response.status.should eql('OK')
    #   end
    # end
  end

  describe '#sizes' do
    describe '#list' do
      let(:response) {
        subject.sizes.list
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end

      it 'should return a list of all droplet sizes' do
        response.sizes.should have_at_least(5).item
      end

      it 'should return the correct ID for the 96GB size' do
        example_size = response.sizes.select { |s| s.name == "96GB" }.first
        example_size.id.should eql(68)
      end
    end
  end

  describe '#regions' do
    describe '#list' do
      let(:response) {
        subject.regions.list
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end

      it 'should return a list of all regions' do
        response.regions.should have_at_least(2).items
      end
    end
  end

  describe '#ssh_keys' do
    describe '#list' do
      let(:response) {
        subject.ssh_keys.list
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end

      it 'should return a list of all SSH keys' do
        response.ssh_keys.should have_at_least(1).item
      end
    end
  end
end
