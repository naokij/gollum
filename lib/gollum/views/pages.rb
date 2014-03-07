require "pathname"

module Precious
  module Views
    class Pages < Layout
      attr_reader :results, :ref
      include Precious::Helpers
      
      def signedin
        @signedin
      end
      
      def not_signedin
        ! @signedin
      end
      
      def title
        "All pages in #{@ref}"
      end

      def breadcrumb
        if @path
          path = Pathname.new(@path)
          breadcrumb = [%{<a href="#{@base_url}/pages/">Home</a>}]
          path.descend do |crumb|
            title = crumb.basename

            if title == path.basename
              breadcrumb << title
            else
              breadcrumb << %{<a href="#{@base_url}/pages/#{crumb}/">#{title}</a>}
            end
          end

          breadcrumb.join(" / ")
        else
          "Home"
        end
      end

      def files_folders
        if has_results
          folder_links = []

          @results.map { |page|
            page_path = page.path.sub(/^#{@path}\//,'')

            if page_path.include?('/')
              folder      = page_path.split('/').first
              folder_path = @path ? "#{@path}/#{folder}" : folder
              folder_link = %{<li><a href="#{@base_url}/pages/#{folder_path}/" class="folder">#{folder}</a></li>}

              unless folder_links.include?(folder_link)
                folder_links << folder_link

                folder_link
              end
            elsif page_path != ".gitkeep"
              begin
                page_title = page_header_from_page_name page.name
                page_tags = page.metadata["tag"]
                page_tags = page_tags.split ' '
              rescue
                #todo
                page_title = page.name + '-<'
                page_tags = []
              end
              if page_tags.count > 0
                tags_html = page_tags.join(" ")
                tags_html = "<span class='tags'><i class=\"icon-tags\"></i> #{tags_html}</span>"
              else
                tags_html = ""
              end
              %{<li><a href="#{@base_url}/#{page.escaped_url_path}" class="file">#{page_title}</a> #{tags_html}</li>}
            end
          }.compact.join("\n")
        else
          ""
        end
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
