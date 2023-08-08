module Spooky
  class Page
    ATTRIBUTES = [
      "canonical_url",
      "codeinjection_foot",
      "codeinjection_head",
      "comment_id",
      "created_at",
      "custom_excerpt",
      "custom_template",
      "excerpt",
      "feature_image",
      "feature_image_alt",
      "feature_image_caption",
      "featured",
      "frontmatter",
      "html",
      "id",
      "meta_description",
      "meta_title",
      "og_description",
      "og_image",
      "og_title",
      "published_at",
      "reading_time",
      "show_title_and_feature_image",
      "slug",
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
  end
end
