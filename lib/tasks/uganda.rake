namespace :uganda do 
  
  namespace :user do 
    desc "create an admin user"
    task :create => :environment do
      
      unless ENV['EMAIL'] and ENV['PASSWORD']
        puts "usage: rake uganda:user:create EMAIL=<your_email> PASSWORD=<password>"
      else
        email = ENV['EMAIL']
        password = ENV['PASSWORD']
        login = email.match(/(.*)@(.*)/)[1]
    
        user = User.new(:password => password, :password_confirmation => password, :email => email)
        user.save!
        user.confirm!
                
        if user.errors.empty?
          puts "#{Time.now} Created backend user with email: #{user.email}, password: #{password}"
        else
          puts "could not create user"
        end
      end
    end
    
  end
end