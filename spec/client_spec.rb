require "spec_helper"

ENV["GHOST_API_URL"] = "https://spec.test"
ENV["GHOST_CONTENT_API_KEY"] = "abc123"

describe Spooky::Client do
  let(:client) { Spooky::Client.new }

  before :each do
    response = double("A parsed response", parse: {})
    allow(HTTP).to receive(:get).and_return(response)
  end

  it "gets all posts" do
    expect(HTTP).to receive(:get).with("https://spec.test/ghost/api/v3/content/posts/", { params: { key: "abc123" } })
    client.posts
  end

  it "gets all posts with tags and authors" do
    expect(HTTP).to receive(:get).with("https://spec.test/ghost/api/v3/content/posts/", { params: { key: "abc123", include: ["tags", "authors"] } })
    client.posts(tags: true, authors: true)
  end

  it "gets a post by id" do
    expect(HTTP).to receive(:get).with("https://spec.test/ghost/api/v3/content/posts/99/", { params: { key: "abc123" } })
    client.post_by(id: 99)
  end

  it "gets a post by slug" do
    expect(HTTP).to receive(:get).with("https://spec.test/ghost/api/v3/content/posts/slug/this-is-a-slug/", { params: { key: "abc123" } })
    client.post_by(slug: 'this-is-a-slug')
  end

  it "gets featured posts with hash filter" do
    expect(HTTP).to receive(:get).with("https://spec.test/ghost/api/v3/content/posts/", { params: { key: "abc123", filter: "featured:true" } })
    client.posts(filter: { featured: true })
  end

  it "applies a string filter to the request" do
    expect(HTTP).to receive(:get).with("https://spec.test/ghost/api/v3/content/posts/", { params: { key: "abc123", filter: "title:Welcome" } })
    client.posts(filter: "title:Welcome")
  end

end
