require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/integer/time'

require 'libs/json_helper'

require 'typhoeus'

module AirportDeparture
  class HttpError < StandardError; end
  class DownloadService
    class << self
      def download(method: :get, params: {}, url:)
        request = Typhoeus::Request.new(url, request_params(method, params))
        request.run
        response = request.response

        raise(HttpError, { code: response.response_code, body: response.response_body }) \
          unless response.success?

        response
      end

    private

      def request_params(method, params)
        {
          cache: cache(params.delete(:cache)),
          method: method,
          forbid_reuse: true,
          followlocation: true,
          ssl_verifypeer: false,
          timeout: 20 }.deep_merge(params)
      end

      def cache(cache)
        cache.present? ? Cache.new : nil
      end
    end
  end

  class Cache
    def initialize
    end

    def get(request)
      file_dir = compute_dir(request)
      return nil unless cached?(request)

      response = read_response(File.read(file_dir))
      if response[:time] < Time.now
        File.delete(file_dir)
        return nil
      end

      response
    end

    def set(request, response)
      return if !response.success? || cached?(request)

      File.write(compute_dir(request), JsonHelper.dump(create_response(response)))
    end

    def create_response(response)
      {
        code: response.code,
        body: response.response_body.force_encoding('utf-8'),
        time: Time.now.since(CACHE[:hour].hour) }
    end

    def cached?(request)
      File.exist?(compute_dir(request))
    end

    def read_response(response)
      parsed = JsonHelper.parse(response)
      OpenStruct.new(
        success?: true,
        response_body: parsed['body'],
        response_code: parsed['code'],
        time: Time.parse(parsed['time']))
    end

  private

    def compute_dir(request)
      File.join(__dir__, '../../tmp/cache', Digest::SHA1.hexdigest(request.base_url))
    end
  end
end