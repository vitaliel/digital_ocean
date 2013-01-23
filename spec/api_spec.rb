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

    describe '#show' do
      let(:response) {
        subject.ssh_keys.show id
      }

      context 'valid' do
        let(:id) { 3738 }

        it 'should be successful' do
          response.status.should eql('OK')
        end

        it 'should return the public keykey' do
          response.ssh_key.ssh_pub_key.should_not be_empty
        end
      end

      context 'invalid' do
        let(:id) { 1 }

        it 'should be successful' do
          response.status.should eql('ERROR')
        end
      end
    end

    describe '#add' do
      pending

      let(:response) {
        subject.ssh_keys.add :name => name, :ssh_key_pub => ssh_key_pub
      }
      let(:name) { 'mobile computer' }
      let(:ssh_key_pub) {'xxx' }

      xit 'should be successful' do
        puts response.status
        response.status.should eql('OK')
      end
    end

    describe '#edit' do
      pending
    end

    describe '#delete' do
      let(:id) { 3928 }

      let(:response) {
        subject.ssh_keys.delete id
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end
    end
  end

  describe '#images' do
    describe '#list' do
      context 'without filter' do
        let(:response) {
          subject.images.list
        }

        it 'should be successful' do
          response.status.should eql('OK')
        end

        it 'should return a list of all images' do
          response.images.should have_at_least(1).item
        end
      end

      context 'with filter: global' do
        let(:response) {
          subject.images.list :filter => 'global'
        }

        it 'should be successful' do
          response.status.should eql('OK')
        end

        it 'should return global images' do
          response.images.should have_at_least(1).item
        end
      end

      context 'with filter: my_images' do
        let(:response) {
          subject.images.list :filter => 'my_images'
        }

        it 'should be successful' do
          response.status.should eql('OK')
        end

        it 'should return my_images' do
          response.images.should have_at_least(1).item
        end
      end
    end

    describe '#show' do
      let(:response) {
        subject.images.show id
      }

      context 'valid' do
        let(:id) { 1601 } # CentOS 5.8 x64

        it 'should be successful' do
          response.status.should eql('OK')
        end

        it 'should return the image' do
          response.image.name.should_not be_empty
          response.image.distribution.should eql('CentOS')
        end
      end

      context 'invalid' do
        let(:id) { 0 }

        it 'should not be successful' do
          response.status.should eql('ERROR')
        end
      end
    end

    describe '#delete' do
      let(:response) {
        subject.images.delete id
      }

      context 'valid' do
        let(:id) { 57089 }

        it 'should be successful' do
          pending
          response.status.should eql('OK')
        end
      end

      context 'invalid' do
        let(:id) { 0 }

        it 'should not be successful' do
          response.status.should eql('ERROR')
        end
      end
    end

  end
end
