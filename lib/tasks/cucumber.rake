# desc "Run all features" 
# task :features => 'db:test:prepare'
# task :features => "features:all" 
# 
# # require 'cucumber/rake/task' #I have to add this -mischa
# 
# namespace :features do
#   Cucumber::Rake::Task.new(:all) do |t|
#     t.cucumber_opts = "--format pretty" 
#   end
# 
#   Cucumber::Rake::Task.new(:cruise) do |t|
#     output_dir = ENV['CC_BUILD_ARTIFACTS'] ? ENV['CC_BUILD_ARTIFACTS'] : '.'
#     
#     # html output breaks rake task (besides its look & feel is terrible)
#     # t.cucumber_opts = "--format pretty --out=#{output_dir}/features.txt --format html --out=#{output_dir}/features.html"
#     
#     t.cucumber_opts = "--format pretty --out=#{output_dir}/features.txt"
#     t.rcov = true
#     t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/ --sort coverage}
#     t.rcov_opts << %[-o "#{output_dir}/features_rcov"]
#   end
# 
#   Cucumber::Rake::Task.new(:rcov) do |t|    
#     t.rcov = true
#     t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/ --sort coverage}
#     t.rcov_opts << %[-o "features_rcov"]
#   end
# end