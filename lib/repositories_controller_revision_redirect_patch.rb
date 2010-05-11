require_dependency 'repositories_controller'

module RepositoriesControllerRevisionRedirectPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :revision, :redirect
    end
  end
  
  module InstanceMethods
    def revision_with_redirect
      s = Setting["plugin_redmine_git_links"]
      puts "^"*300
      puts s.inspect
      if s['git_link_redirect_on']
        repo_url = @repository.url.scan(/([^\/.]+)([\/]?\.git)?\z/i).first
        repo_url = repo_url && repo_url.first 
        redirect_to( s["git_link_url"].
            gsub('%project_name%',@project.name).
            gsub('%project_id%',@project.identifier).
            gsub('%rev%',@rev).
            gsub('%repo_url%',repo_url)
        )
      else
        revision_without_redirect
      end
    end

  end
end

