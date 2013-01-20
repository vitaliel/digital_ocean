require 'spec_helper'

describe DigitalOcean do
  it 'should have a version number' do
    DigitalOcean::VERSION.should_not be_nil
  end
end
