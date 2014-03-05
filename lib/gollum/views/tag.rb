module Precious
  module Views
    class Tag < Layout
      attr_reader :content, :page, :footer, :results, :tag

      def signedin
        @signedin
      end
      
      def not_signedin
        ! @signedin
      end
      
      def title
        "Tags / " + @tag
      end

      def has_results
        !@results.empty?
      end

      def no_results
        @results.empty?
      end

    end
  end
end
