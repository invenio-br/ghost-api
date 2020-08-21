module IsResource
  def self.included(base)
    base.class_eval do
      attr_reader(*const_get("ATTRIBUTES"))

      def initialize(attrs = {})
        self.class.const_get("ATTRIBUTES").each do |attribute|
          instance_variable_set("@#{attribute}", attrs[attribute])
        end

        parse_datetimes(attrs)
        parse_attributes(attrs)
      end

      def parse_datetimes(attrs)
        ["created_at", "updated_at", "published_at"].each do |date_attr|
          instance_variable_set("@#{date_attr}", DateTime.iso8601(attrs[date_attr])) if attrs[date_attr].present?
        end
      end

      def parse_attributes(attrs)
        # Abstract method, should be overridden in child if needed.
      end
    end
  end
end
