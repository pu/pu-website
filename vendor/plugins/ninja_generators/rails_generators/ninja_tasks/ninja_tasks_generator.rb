class NinjaTasksGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.file 'cruise.rake', 'lib/tasks/cruise.rake'
      m.file 'cucumber.rake', 'lib/tasks/cucumber.rake'
      m.file 'database.rake', 'lib/tasks/database.rake'
      m.file 'annotate.rake', 'lib/tasks/annotate.rake'
    end
  end
  
end