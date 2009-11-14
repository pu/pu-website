# Install hook code here
puts "Copying files..."
dir = "javascripts"
pwd = File.dirname(__FILE__)
js_file = "jquery_rails_ujs_helper.js"
source_file = File.join(pwd, dir, js_file)
destination_file = File.join(RAILS_ROOT, "public", dir, js_file)
FileUtils.cp_r(src_file, dest_file)
puts "Files copied - Installation complete!"