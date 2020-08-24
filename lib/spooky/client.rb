require "http"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/string/inflections"

module Spooky
  class Client
    attr_accessor :api_url, :api_key, :endpoint, :error

    def initialize(attrs = {})
      @api_url = ENV["GHOST_API_URL"] || attrs[:api_url]
      @api_key = ENV["GHOST_CONTENT_API_KEY"] || attrs[:api_key]
      @endpoint = "#{@api_url}/ghost/api/v3/content"
    end

    def fetch_json(resource, options = {})
      options.merge!(key: @api_key)
      url = "#{@endpoint}/#{resource}/"
      response = HTTP.get(url, params: options).parse

      if response["errors"].present?
        @error = response["errors"]
        false
      else
        collection = response[resource.split("/").first]
        pagination = response.dig("meta", "pagination")

        [collection, pagination]
      end
    end

    def fetch(resource, options = {})
      resource_name = resource.split("/").first
      response, pagination = fetch_json(resource, options)

      resource_class = "Spooky::#{resource_name.singularize.classify}".constantize

      response.present? && [response.map { |attrs| resource_class.send(:new, attrs) }, pagination]
    end

    def posts(tags: false, authors: false, filter: false, page: false, limit: false)
      inc = []
      inc << "tags" if tags
      inc << "authors" if authors

      options = {}
      options[:include] = inc if inc.present?

      options = apply_filter(options, filter)
      options = apply_pagination(options, { page: page, limit: limit })

      fetch("posts", options)
    end

    def post_by(id: nil, slug: nil, tags: false, authors: false)
      inc = []
      inc << "tags" if tags
      inc << "authors" if authors

      options = {}
      options[:include] = inc if inc.present?

      if id.present?
        response, _ = fetch("posts/#{id}", options)
        response.present? && response.first
      elsif slug.present?
        response, _ = fetch("posts/slug/#{slug}", options)
        response.present? && response.first
      else
        false
      end
    end

    private

    def apply_filter(options, filter)
      if filter.present?
        if filter.is_a?(Hash)
          options[:filter] = filter.map { |k, v| "#{k}:#{v}" }.join("+")
        else
          options[:filter] = filter
        end
      end

      options
    end

    def apply_pagination(options, pagination)
      options[:page] = pagination[:page] if pagination[:page]
      options[:limit] = pagination[:limit] if pagination[:limit]

      options
    end
  end
end
