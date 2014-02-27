# ~*~ encoding: utf-8 ~*~
module Precious
  module Helpers
    # Extract the path string that Gollum::Wiki expects
    def extract_path(file_path)
      return nil if file_path.nil?
      last_slash = file_path.rindex("/")
      if last_slash
        file_path[0, last_slash]
      end
    end

    # Extract the 'page' name from the file_path
    def extract_name(file_path)
      if file_path[-1, 1] == "/"
        return nil
      end

      # File.basename is too eager to please and will return the last
      # component of the path even if it ends with a directory separator.
      ::File.basename(file_path)
    end

    def sanitize_empty_params(param)
      [nil,''].include?(param) ? nil : CGI.unescape(param)
    end

    # Ensure path begins with a single leading slash
    def clean_path(path)
      if path
        (path[0] != '/' ? path.insert(0, '/') : path).gsub(/\/{2,}/,'/')
      end
    end

    # Remove all slashes from the start of string.
    # Remove all double slashes
    def clean_url url
      return url if url.nil?
      url.gsub('%2F','/').gsub(/^\/+/,'').gsub('//','/')
    end

    # Get page title form content of given page name
    def page_header_from_page_name page_name
      wiki = Gollum::Wiki.new(Precious::App.settings.gollum_path, Precious::App.settings.wiki_options)
      page = wiki.page page_name
      content = page.formatted_data
      doc = Nokogiri::HTML::fragment(%{<div id="gollum-root">} + content.to_s + %{</div>}, 'UTF-8')
      title = find_page_header_node(doc, page).inner_text.strip
      title = nil if title.empty?
      title
    end
    
    # Finds page header node inside Nokogiri::HTML document.
    #
    def find_page_header_node(doc, page)
      case page.format
        when :asciidoc
          doc.css("div#gollum-root > div#header > h1:first-child")
        when :org
          doc.css("div#gollum-root > p.title:first-child")
        when :pod
          doc.css("div#gollum-root > a.dummyTopAnchor:first-child + h1")
        when :rest
          doc.css("div#gollum-root > div > div > h1:first-child")
        else
          doc.css("div#gollum-root > h1:first-child")
      end
    end
    
  end
end
