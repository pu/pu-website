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
    Parent.all.each{ |parent| 
      NewsletterMailer.deliver_newsletter_to(parent, self)
    }
    self.update_attribute(:sent_at, Time.now)
  end
  
  def self.human_attribute_name(a)
    ""
  end

end