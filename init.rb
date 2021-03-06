require 'redmine'

Redmine::Plugin.register :redmine_git_links do
  name 'Redmine Git Links plugin'
  author 'Cameron Banta'
  description 'This plugin allows you to change where the git revision link points to (to use cgit for example)'
  version '0.0.1'
  settings :default =>{
      'git_link_url' => '/cgit/%project_id%/commit/?id=%rev%',
      'git_link_url_on' => false,
      'git_link_redirect_on' => false,
    }, :partial => 'settings/git_links_plugin_settings'
end

RepositoriesController.send(:include, RepositoriesControllerRevisionRedirectPatch)
