class NinjaHamlGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.file 'haml_generator.rb', 'config/initializers/haml_generator.rb'
      m.file 'sass.rake', 'lib/tasks/sass.rake'
      m.file 'compass.rb', 'config/initializers/compass.rb'
      m.file 'compass.config', 'config/compass.config'
    end
  end
  
end