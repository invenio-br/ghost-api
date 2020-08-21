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
        response[resource.split("/").first]
      end
    end

    def fetch(resource, options = {})
      resource_name = resource.split("/").first
      response = fetch_json(resource, options)

      resource_class = "Spooky::#{resource_name.singularize.classify}".constantize

      response.present? && response.map { |attrs| resource_class.send(:new, attrs) }
    end

    def posts(tags: false, authors: false, filter: false)
      inc = []
      inc << "tags" if tags
      inc << "authors" if authors

      options = {}
      options[:include] = inc if inc.present?

      if filter.present?
        if filter.is_a?(Hash)
          options[:filter] = filter.map { |k, v| "#{k}:#{v}" }.join
        else
          options[:filter] = filter
        end
      end

      fetch("posts", options)
    end

    def post_by(id: nil, slug: nil, tags: false, authors: false)
      inc = []
      inc << "tags" if tags
      inc << "authors" if authors

      options = {}
      options[:include] = inc if inc.present?

      if id.present?
        response = fetch("posts/#{id}", options)
        response.present? && response.first
      elsif slug.present?
        response = fetch("posts/slug/#{slug}", options)
        response.present? && response.first
      else
        false
      end
    end
  end
end
