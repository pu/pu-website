class KidsMailer < ActionMailer::Base
  
  def profile(receiver_email, kid)
    setup_email(receiver_email)
    
    subj(" #{kid.firstname} #{kid.name} Profildaten")    
  
    body[:kid] = kid
      
    unless kid.picture_file_name.nil?
      attachment "img/jpg" do |a|
        a.filename = kid.picture_file_name
        a.body = File.read(kid.picture.path(:large))
      end
    end
    
  end

  protected

  def subj(str)
    subject(subject + str)
  end
  
  def setup_email(receiver_email)
    ActionMailer::Base.logger ||= Logger.new(File.join(Rails.root, "log", "outgoing_email.log"))
    
    recipients "#{receiver_email}"
    from       "Projekthilfe Uganda <info@projekthilfe-uganda.de>" 
    subject    "[Uganda Infobrief] "
    sent_on    Time.now
    headers({"return-path" => "info@projekthilfe-uganda.de"})
  end

end