require 'spec_helper'

describe 'influxdb_relay' do

  describe service('influxdb-relay') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe port(9096) do
    it { should be_listening }
  end
  describe port(9098) do
    it { should be_listening }
  end
  describe port(8089) do
    it { should be_listening }
  end
end
