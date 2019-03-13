require "howareya/errors"
require "howareya/configuration"
require "howareya/version"

module Howareya
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.details
    { api_key: @configuration.api_key, url: @configuration.url}
  end

  def self.record_metric key, value
    response = ::HTTParty.post(@configuration.url, :body => { :api_key => @configuration.api_key, 
                                              :key => key, 
                                              :value => value })
    raise Howareya::MissingMetricError if response.code === 404
    raise Howareya::BadAPIKeyError if response.code === 401
  end

end
