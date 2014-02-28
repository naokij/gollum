# Example gollum config
# gollum ../wiki --config config.rb
#
# or run from source with
#
# bundle exec bin/gollum ../wiki/ --config config.rb

# Remove const to avoid
# warning: already initialized constant FORMAT_NAMES
#
# only remove if it's defined.
# constant Gollum::Page::FORMAT_NAMES not defined (NameError)
Gollum::Page.send :remove_const, :FORMAT_NAMES if defined? Gollum::Page::FORMAT_NAMES
# limit to one format
Gollum::Page::FORMAT_NAMES = { :markdown  => "Markdown" }

=begin
put these lines on top of config.ru on wiki repository
ENV['ldap_host'] = '10.0.0.1'
ENV['ldap_port'] = '3268'
ENV['ldap_base'] = 'DC=northwind,DC=com'
ENV['ldap_uid'] = 'sAMAccountName'
ENV['ldap_bind_dn'] = 'CN=ldap helper,OU=northwind.com,DC=northwind,DC=com'
ENV['ldap_password'] = 'password'
=end

=begin
Valid formats are:
{ :markdown  => "Markdown",
  :textile   => "Textile",
  :rdoc      => "RDoc",
  :org       => "Org-mode",
  :creole    => "Creole",
  :rest      => "reStructuredText",
  :asciidoc  => "AsciiDoc",
  :mediawiki => "MediaWiki",
  :pod       => "Pod" }
=end
