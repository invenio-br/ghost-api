module Spooky
  class Tag
    ATTRIBUTES = [
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
