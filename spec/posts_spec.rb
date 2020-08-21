require "spec_helper"
require "fixtures"

describe Spooky::Post do
  let(:client) { Spooky::Client.new }

  it "returns an array of Posts" do
    response = double("A parsed response", parse: FIXTURES[:simple_posts])
    allow(HTTP).to receive(:get).and_return(response)

    expect(client.posts.all? { |p| p.is_a?(Spooky::Post) }).to be(true)
  end

  it "converts nested tags to Spooky::Tag" do
    response = double("A parsed response", parse: FIXTURES[:posts_with_tags])
    allow(HTTP).to receive(:get).and_return(response)

    post = client.posts(tags: true).first
    expect(post.primary_tag.is_a?(Spooky::Tag)).to be(true)
    expect(post.tags.all? { |p| p.is_a?(Spooky::Tag) }).to be(true)
  end

  it "converts nested authors to Spooky::Author" do
    response = double("A parsed response", parse: FIXTURES[:posts_with_authors])
    allow(HTTP).to receive(:get).and_return(response)

    post = client.posts(authors: true).first
    expect(post.primary_author.is_a?(Spooky::Author)).to be(true)
    expect(post.authors.all? { |p| p.is_a?(Spooky::Author) }).to be(true)
  end

  it "returns a requested post by ID" do
    response = double("A parsed response", parse: FIXTURES[:simple_posts])
    allow(HTTP).to receive(:get).and_return(response)

    # This doesn't actually query by the ID. We are testing attribute creation here.
    post = client.post_by(id: "5f397fe1a185384852d1f1a5")

    expect(post.id).to eq("5f397fe1a185384852d1f1a5")
    expect(post.title).to eq("Welcome to Ghost")
    expect(post.slug).to eq("welcome")
  end
end
