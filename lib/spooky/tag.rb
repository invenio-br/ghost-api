module Spooky
  class Tag
    ATTRIBUTES = [
      "accent_color",
      "description",
      "feature_image",
      "id",
      "meta_description",
      "meta_title",
      "name",
      "slug",
      "url",
      "visibility"
    ].freeze

    include IsResource
  end
end
