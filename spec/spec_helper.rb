ENV["GHOST_API_URL"] = "https://spec.test"
ENV["GHOST_CONTENT_API_KEY"] = "abc123"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "spooky"
