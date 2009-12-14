class Kid < ActiveRecord::Base
  attr_accessible :name, :firstname, :birthday, :description, :number, :sponsored_until, :picture, :school_id

  has_many :parentships  
  has_many :parents, :through => :parentships
  
  belongs_to :school
  
  
  has_attached_file :picture, :styles => { :thumb => ["24x24#", :jpg], :profile => ["100x100#", :jpg] , :large => ["240x240#", :jpg], :full => ["800x600>", :jpg] }, :convert_options => {:all => "-strip -quality 80"},
                                                           :path => ":rails_root/public/pictures/:basename_:style.:extension", 
                                                           :url => "/pictures/:basename_:style.:extension", 
                                                           :default_url => "/pictures/dummy_:style.png"

 validates_attachment_content_type :picture, :content_type => ["image/bmp", "image/jpeg", "image/pjpeg", "image/jpg", "image/pjpg", "image/png", "image/x-png", "image/gif"], :message => "Du kannst hier nur Bilder (GIF, JPEG oder PNG) hochladen"

 validates_attachment_size :picture, :less_than => 2.megabyte, :message => "Dein Bild kann höchstens 2 MB gross sein"

 validates_uniqueness_of :number, :message => "Diese Nummer ist bereits vergeben"
 
 validates_presence_of :firstname, :name, :number, :message => " darf nicht leer sein"
end
