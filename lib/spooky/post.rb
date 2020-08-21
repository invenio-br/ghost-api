module Spooky
  class Post
    ATTRIBUTES = [
      "authors",
      "canonical_url",
      "codeinjection_foot",
      "codeinjection_head",
      "comment_id",
      "created_at",
      "custom_excerpt",
      "custom_template",
      "email_subject",
      "excerpt",
      "feature_image",
      "featured",
      "html",
      "id",
      "meta_description",
      "meta_title",
      "og_description",
      "og_image",
      "og_title",
      "primary_author",
      "primary_tag",
      "published_at",
      "reading_time",
      "send_email_when_published",
      "slug",
      "tags",
      "title",
      "twitter_description",
      "twitter_image",
      "twitter_title",
      "updated_at",
      "url",
      "uuid",
      "visibility"
    ].freeze

    include IsResource

    def parse_attributes(attrs)
      author = attrs["primary_author"]
      @primary_author = author.present? && Spooky::Author.new(author)

      @authors = (attrs["authors"] || []).map do |author|
        Spooky::Author.new(author)
      end

      tag = attrs["primary_tag"]
      @primary_tag = tag.present? && Spooky::Tag.new(tag)

      @tags = (attrs["tags"] || []).map do |tag|
        Spooky::Tag.new(tag)
      end
    end
  end
end
