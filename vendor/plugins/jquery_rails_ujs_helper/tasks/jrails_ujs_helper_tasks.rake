namespace :jquery_rails_ujs_helper do
	namespace :update do
		desc "Copies the jQuery Rails Ujs helper javascripts to public/javascripts"
		task :javascripts do
			puts "Copying files..."
			project_dir = RAILS_ROOT + '/public/javascripts/'
			scripts = Dir[File.join(File.dirname(__FILE__), '..') + '/javascripts/*.js']
			FileUtils.cp(scripts, project_dir)
			puts "files copied successfully."
		end
	end
	
	namespace :install do
		desc "Installs the jQuery Rails Ujs helper javascripts to public/javascripts"
		task :javascripts do
			Rake::Task['jquery_rails_ujs_helper:update:javascripts'].invoke
		end
	end
end
