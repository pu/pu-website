class Newsletter < ActiveRecord::Base
  
  attr_accessible :attachment, :sent_at, :subject, :body
  
  validates_presence_of :subject, :message => "Bitte einen Betreff angeben"
  validates_presence_of :body, :message => "Bitte einen Nachrichtentext angeben"


  has_attached_file :attachment, 
        :styles => { :thumb => ["64x64#", :pdf], :large => ["128x128#", :pdf]},
        :convert_options => {:all => "-strip -quality 80"}, 
        :path => ":rails_root/public/newsletters/:basename_:style.:extension",
        :url => "/newsletters/:basename_:style.:extension"

  def send_to_all_parents
    parent_email_array = Parent.all.collect{ |p| p.email}
    send_to(parent_email_array)
    self.update_attribute(:sent_at, Time.now)
  end
  
  def send_to(receiver_email_array)
    receiver_email_array.each{ |receiver| 
      NewsletterMailer.deliver_newsletter_to(receiver, self)
    }   
  end
  
  def self.human_attribute_name(a)
    ""
  end

end