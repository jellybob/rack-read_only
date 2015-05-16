require 'spec_helper'

describe Rack::ReadOnly do
  it 'has a version number' do
    expect(Rack::ReadOnly::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
