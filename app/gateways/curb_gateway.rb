require "net/http"

class CurbGateway
  THROWS = %w[rock paper scissors]
  HEADERS = {
    "Accept" => "application/json",
    "Content-Type" => "application/json"
  }

  def initialize
    @base_url = ENV.fetch("CURB_API_URL")
  end

  def get_throw
    uri = URI(@base_url + "/rps-stage/throw")
    opts = {use_ssl: true}
    response = Net::HTTP.start(uri.hostname, uri.port, opts) do |http|
      http.request_get(uri, HEADERS)
    end
    parse_response(response)
  end

  private

  def parse_response(response)
    if response.code == Rack::Utils.status_code(:ok).to_s
      result = JSON.parse(response.body, symbolize_names: true)
      result[:body]
    else
      THROWS.sample
    end
  end
end