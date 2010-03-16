class NewsletterMailer < ActionMailer::Base
  
  def newsletter_to(receiver, newsletter)
    setup_email(receiver)
    subj(newsletter.subject)
    body(newsletter.body)
    
    attachment "application/pdf" do |a|
      a.filename = newsletter.attachment_file_name
      a.body = File.read(newsletter.attachment.path)
    end
    
  end

  protected

  def subj(str)
    subject(subject + str)
  end
  
  def setup_email(receiver)
    ActionMailer::Base.logger ||= Logger.new(File.join(Rails.root, "log", "outgoing_email.log"))
    
    recipients "#{receiver.email}"
    from       "Projekthilfe Uganda <info@projekthilfe-uganda.de>" 
    subject    "[Uganda Infobrief] "
    sent_on    Time.now
    headers({"return-path" => "info@projekthilfe-uganda.de"})
  end

end