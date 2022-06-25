class DubaiController < ApplicationController
  include Prometheus::Controller

  require 'net/http'
  require 'json'

  def temperature
    GAUGE_TEMP
      .set(dubai)

    respond_to do |format|
      format.any do
        render json: dubai, status: 200
      end
    end
  end

  def dubai
    # Get the weather data for Dubai
    uri = URI('https://api.openweathermap.org/data/2.5/weather?')
    params = { q: 'Dubai', appid: '6dce072d644ec3475ed2866ffb4b2cf4' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)

    # Convert the response from string to hash
    result = res.body if res.is_a?(Net::HTTPSuccess)
    result = JSON.parse(result, symbolize_names: true)

    # Print the response and convert to integer
    result[:main][:temp].to_i
  end
end
