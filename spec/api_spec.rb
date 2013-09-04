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

  describe 'ssl settings' do
    it 'should by default enforce ssl' do
      subject.default_faraday.ssl.should == { :verify => true }
    end
  end

  describe '#droplets' do
    let(:droplet_id) { 106265 }

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

    describe '#show' do
      let(:id) { 83102 }
      let(:response) {
        subject.droplets.show id
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end
    end

    describe '#create' do
      let(:name)        { 't1'  } # "Only valid hostname characters are allowed. (a-z, A-Z, 0-9, . and -)"
      let(:size_id)     { 66    } # 512MB
      let(:image_id)    { 25306 } # Ubuntu 12.10 x32 Server
      let(:region_id)   { 2     } # Amsterdam/NL
      let(:ssh_key_ids) { [] }

      let(:response) {
        subject.droplets.create :name        => name,
                                :size_id     => size_id,
                                :image_id    => image_id,
                                :region_id   => region_id,
                                :ssh_key_ids => ssh_key_ids
      }

      it 'should be successful' do
        # #<Hashie::Rash droplet=#<Hashie::Rash event_id=123456 id=87071 image_id=25306 name="t1" size_id=66> status="OK">
        response.status.should eql('OK')
      end

      it 'should return droplet.id' do
        response.droplet.id.should_not be_nil
      end
    end

    describe '#reboot' do
      let(:response) {
        subject.droplets.reboot droplet_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#power_cycle' do
      let(:response) {
        subject.droplets.power_cycle droplet_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#shutdown' do
      let(:response) {
        subject.droplets.shutdown droplet_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#power_on' do
      let(:response) {
        subject.droplets.power_on droplet_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#power_off' do
      let(:response) {
        subject.droplets.power_off droplet_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#password_reset' do
      let(:response) {
        subject.droplets.password_reset droplet_id
      }

      it 'should be successful' do
        # an mail with login/password is triggered...
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#resize' do
      let(:new_size_id) { 63 }  # 1GB RAM

      let(:response) {
        subject.droplets.resize droplet_id, :size_id => new_size_id
      }

      it 'should be successful' do
        # Note: you need to do a full powercycle after this!
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#snapshot' do
      let(:snapshot_name) { 'test_snapshot_1' }
      let(:response) {
        subject.droplets.snapshot droplet_id, :name => snapshot_name
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#restore' do
      let(:image_id) { 57658 }
      let(:response) {
        subject.droplets.restore droplet_id, :image_id => image_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#rebuild' do
      let(:image_id) { 57658 }
      let(:response) {
        subject.droplets.rebuild droplet_id, :image_id => image_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#enable_backups' do
      let(:response) {
        subject.droplets.enable_backups droplet_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#disable_backups' do
      let(:response) {
        subject.droplets.disable_backups droplet_id
      }

      it 'should be successful' do
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end

    describe '#delete' do
      let(:response) {
        subject.droplets.delete droplet_id
      }

      it 'should be successful' do
        puts response.inspect
        #<Hashie::Rash event_id=123456 status="OK">
        response.status.should eql('OK')
      end
    end
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
    let(:test_ssh_key_id) { 6757 }

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

        it 'should not be successful' do
          response.status.should eql('ERROR')
        end
      end
    end

    describe '#add' do
      let(:response) {
        subject.ssh_keys.add :name => name, :ssh_pub_key => ssh_key_pub
      }
      let(:name) { 'mobile computer' }
      let(:ssh_key_pub) { 'ssh-dss AAAAB3NzaC1kc3MAAACBAPUify/0h4QLkkhfMiOr8o5R6LEzV1ETC4cd7UgKUiLsX8+E+s5hmbP6QvkWVyc1qpXuH7zyFj/FY5XSBdNyVVUblOxrOJVo9wPdl5ZaXxMkx+/xokVqfDvoeQa5adaBbk11xjt7F72KBeWb5WwZScblK4kOIrVT5HzNxl58xE2XAAAAFQDyqQMKaDAoUcUlEeoFC962WZE6kQAAAIAv83TOiGZ81zIqJ1+AQNNeUoXbDF/u0B5qVgmr8rGxJ/C24M/LaLqpWB0fNb1xSF1luT33BN/NEFJ/MiUA53yffXkjFMcBbJPVDuxHh7/qLOWX0SlrH6IhKvTU6iowPb+m0bBXQM8z6jR1Xyl6F2eb3HZfW0O15i+wDCjPeplfpwAAAIEA1zxtI3CackcnOAH2su9v/SBZPrfyir52ie1/+rH0WVnnAbc7yJRMOuRHZCZo4MXoQ+9/QoxBBxvBinabrlVPvwnRgGIOTcHOlo8Hs07THA6mlnLUcG/QNKFyR25XI86ntx3dg+n89fUo302dWZAQ5vSl5nbqvsBs56wfWFvOYS8= test@example.com' }

      it 'should be successful' do
        response.status.should eql('OK')
      end
    end

    describe '#edit' do
      let(:response) {
        subject.ssh_keys.edit test_ssh_key_id, :name => name, :ssh_pub_key => ssh_key_pub
      }
      let(:name) { 'mobile computer new' }
      let(:ssh_key_pub) { 'ssh-rsa AAAAB3NzaC1kc3MAAACBAPUify/0h4QLkkhfMiOr8o5R6LEzV1ETC4cd7UgKUiLsX8+E+s5hmbP6QvkWVyc1qpXuH7zyFj/FY5XSBdNyVVUblOxrOJVo9wPdl5ZaXxMkx+/xokVqfDvoeQa5adaBbk11xjt7F72KBeWb5WwZScblK4kOIrVT5HzNxl58xE2XAAAAFQDyqQMKaDAoUcUlEeoFC962WZE6kQAAAIAv83TOiGZ81zIqJ1+AQNNeUoXbDF/u0B5qVgmr8rGxJ/C24M/LaLqpWB0fNb1xSF1luT33BN/NEFJ/MiUA53yffXkjFMcBbJPVDuxHh7/qLOWX0SlrH6IhKvTU6iowPb+m0bBXQM8z6jR1Xyl6F2eb3HZfW0O15i+wDCjPeplfpwAAAIEA1zxtI3CackcnOAH2su9v/SBZPrfyir52ie1/+rH0WVnnAbc7yJRMOuRHZCZo4MXoQ+9/QoxBBxvBinabrlVPvwnRgGIOTcHOlo8Hs07THA6mlnLUcG/QNKFyR25XI86ntx3dg+n89fUo302dWZAQ5vSl5nbqvsBs56wfWFvOYS8= test@example.com' }

      it 'should be successful' do
        response.status.should eql('OK')
      end
    end

    describe '#delete' do
      let(:name) { 'test_for_deletion' }
      let(:ssh_key_pub) { 'ssh-dss AAAAB3NzaC1kc3MAAACBAPUify/0h4QLkkhfMiOr8o5R6LEzV1ETC4cd7UgKUiLsX8+E+s5hmbP6QvkWVyc1qpXuH7zyFj/FY5XSBdNyVVUblOxrOJVo9wPdl5ZaXxMkx+/xokVqfDvoeQa5adaBbk11xjt7F72KBeWb5WwZScblK4kOIrVT5HzNxl58xE2XAAAAFQDyqQMKaDAoUcUlEeoFC962WZE6kQAAAIAv83TOiGZ81zIqJ1+AQNNeUoXbDF/u0B5qVgmr8rGxJ/C24M/LaLqpWB0fNb1xSF1luT33BN/NEFJ/MiUA53yffXkjFMcBbJPVDuxHh7/qLOWX0SlrH6IhKvTU6iowPb+m0bBXQM8z6jR1Xyl6F2eb3HZfW0O15i+wDCjPeplfpwAAAIEA1zxtI3CackcnOAH2su9v/SBZPrfyir52ie1/+rH0WVnnAbc7yJRMOuRHZCZo4MXoQ+9/QoxBBxvBinabrlVPvwnRgGIOTcHOlo8Hs07THA6mlnLUcG/QNKFyR25XI86ntx3dg+n89fUo302dWZAQ5vSl5nbqvsBs56wfWFvOYS8= test@example.com' }

      let!(:create_response) {
        subject.dup.ssh_keys.add :name => name, :ssh_pub_key => ssh_key_pub
      }

      let(:response) {
        subject.ssh_keys.delete create_response.ssh_key.id
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
          pending "does not work, ask digitalocean to fix"
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

  describe '#domains' do
    describe '#list' do
      let(:response) {
        subject.domains.list
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end

      it 'should return a list of all domains' do
        response.domains.should have_at_least(1).item
      end
    end

    describe '#show' do
      let(:id) { 26230 }
      let(:response) {
        subject.domains.show id
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end
    end

    describe '#create' do
      let(:name)        { 'test.do.cityhawk.ru'  }
      let(:ip_address)  { '192.81.213.70' }

      let(:response) {
        subject.domains.create :name        => name,
                               :ip_address  => ip_address
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end

      it 'should return domain.id' do
        response.domain.id.should_not be_nil
      end
    end

    describe '#delete' do
      let(:domain_id) { 30158 }
      let(:response) {
        subject.domains.delete domain_id
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end
    end

    let(:record_domain_id) { 30163 }

    describe '#list_records' do
      let(:response) {
        subject.domains.list_records record_domain_id
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end

      it 'should return a list of all domain records' do
        response.records.should have_at_least(1).item
      end
    end

    describe '#show_record' do
      let(:record_id) { 206982 }
      let(:response) {
        subject.domains.show_record record_domain_id, record_id
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end
    end

    describe '#create_record' do
      let(:record_type)        { 'TXT'  }
      let(:name)  { 'foo' }
      let(:data)  { 'bar' }

      let(:response) {
        subject.domains.create_record record_domain_id,
                                      :record_type => record_type,
                                      :name        => name,
                                      :data        => data
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end

      it 'should return record.id' do
        response.record.id.should_not be_nil
      end
    end

    describe '#delete_record' do
      let(:record_id) { 206997 }
      let(:response) {
        subject.domains.delete_record record_domain_id, record_id
      }

      it 'should be successful' do
        response.status.should eql('OK')
      end
    end

  end
end
