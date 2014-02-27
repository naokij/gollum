module Precious
  module Views
    class Tags < Layout
      attr_reader :content, :page, :footer, :tags

      def title
        "Tags"
      end

      def has_tagcloud
        !@tags.empty?
      end

      def no_tagcloud
        @tags.empty?
      end

      
    end
  end
end
