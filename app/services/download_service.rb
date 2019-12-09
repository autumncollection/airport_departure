require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/object/blank'
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
          #cache: cache(params.delete(:cache)),
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
      if File.exist?(file_dir)
        File.read(file_dir)
      else
        nil
      end
    end

    def set(request, response)
      File.write(compute_dir(request), response)
    end

  private

    def compute_dir(request)
      File.join(__dir__, '../../tmp/cache', Digest::SHA1.digest(request.base_url))
    end
  end
end