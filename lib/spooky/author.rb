module Spooky
  class Author
    ATTRIBUTES = [
      "bio",
      "cover_image",
      "facebook",
      "id",
      "location",
      "meta_description",
      "meta_title",
      "name",
      "profile_image",
      "slug",
      "twitter",
      "url",
      "website"
    ].freeze

    include IsResource
  end
end
