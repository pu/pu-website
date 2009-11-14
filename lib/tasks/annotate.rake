namespace :db do
  desc "annotate models"
  task :annotate => ['migrate'] do
    sh 'annotate'
  end

  namespace :migrate do
    desc "run migrations and annotate models"
    task :annotate => ['db:migrate'] do
      sh 'annotate'
    end
  end
end