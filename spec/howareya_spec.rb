require "spec_helper"
require "httparty"

RSpec.describe Howareya do
  let(:url){"http://www.example.com/howareya/record_metric"}
  let(:api_key){"howareya api key"}

  it "has a version number" do
    expect(Howareya::VERSION).not_to be nil
  end

  it "can be setup with a url and an API key" do
    Howareya.configure do |config|
      config.url = url
      config.api_key = api_key
    end
    expect(Howareya.details).to eq({ api_key: api_key, url: url})
  end

  context "when setup" do
    before do
      Howareya.configure do |config|
        config.url = url
        config.api_key = api_key
      end
    end

    it "calls out to httparty" do
      expect(HTTParty).to receive(:post) { double :response, code: 200 }
      Howareya.record_metric("Foo", 123)
    end

    context "with a bad api key"  do
      before { allow(HTTParty).to receive(:post) { double :response, code: 401 } }
      it "raises an error" do
        expect {
          Howareya.record_metric("Foo", 123)
        }.to raise_error(Howareya::BadAPIKeyError)
      end
    end

    context "with a bad metric key"  do
      before { allow(HTTParty).to receive(:post) { double :response, code: 404 } }
      it "raises an error" do
        expect {
          Howareya.record_metric("Foo", 123)
        }.to raise_error(Howareya::MissingMetricError)
      end
    end

  end
end
