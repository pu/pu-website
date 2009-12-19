class Kid < ActiveRecord::Base
  attr_accessible :name, :firstname, :birthday, :description, :number, :sponsored_until, :picture, :school_id

  has_many :parentships, :dependent => :destroy  
  has_many :parents, :through => :parentships
  
  belongs_to :school
  
  has_many :letters_written
  
  
  has_attached_file :picture, :styles => { :thumb => ["24x24#", :jpg], :profile => ["100x100#", :jpg] , :large => ["240x240#", :jpg], :full => ["800x600>", :jpg] }, :convert_options => {:all => "-strip -quality 80"},
                                                           :path => ":rails_root/public/pictures/:basename_:style.:extension", 
                                                           :url => "/pictures/:basename_:style.:extension", 
                                                           :default_url => "/pictures/dummy_:style.png"

 validates_attachment_content_type :picture, :content_type => ["image/bmp", "image/jpeg", "image/pjpeg", "image/jpg", "image/pjpg", "image/png", "image/x-png", "image/gif"], :message => "Du kannst hier nur Bilder (GIF, JPEG oder PNG) hochladen"

 validates_attachment_size :picture, :less_than => 2.megabyte, :message => "Dein Bild kann höchstens 2 MB gross sein"

 validates_uniqueness_of :number, :message => "Diese Nummer ist bereits vergeben"
 
 validates_presence_of :firstname, :name, :number, :message => " darf nicht leer sein"
 
 after_create :create_all_letters_written
 
 def recent_letters_written
   recent_letters = Letter.find(:all, :order => "due_date DESC", :limit => 2)
   
   recent_letters.collect{ |l|
     self.letters_written.find_by_letter_id(l)
     }.compact
 end
 
 private
 
 def create_all_letters_written
   Letter.find(:all).each{ |l|
     LettersWritten.find_or_create_by_kid_id_and_letter_id_and_received(self.id, l.id, false)
   }
 end
 
end
