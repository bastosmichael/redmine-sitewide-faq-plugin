require 'redmine'

Redmine::Plugin.register :redmine_faq do
  name 'SiteWide FAQ Plugin'
  author 'Michael Bastos'
  description 'Provides site wide FAQ feature enabled on the top menu bar.'
  #Creates a new link in the top level menu bar.
  menu :top_menu, :faq, { :controller => 'faq', :action => 'index' }, :caption => 'FAQ', :after => :administration
end
