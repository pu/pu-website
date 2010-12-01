class Kid < ActiveRecord::Base
  attr_accessible :name, :firstname, :birthday, :description, :number, :sponsored_until, :school_id, :picture, :town, :grade

  has_many :parentships
  has_many :parents, :through => :parentships

  has_one :school, :through => :school_visit
  has_one :school_visit

  has_many :letters_written

  accepts_nested_attributes_for :school_visit, :school

  has_attached_file :picture, :styles => { :thumb => ["24x24#", :jpg], :profile => ["100x100#", :jpg] , :large => ["240x240#", :jpg], :full => ["800x600>", :jpg] }, :convert_options => {:all => "-strip -quality 80"},
                                                           :path => ":rails_root/public/pictures/kids/:basename_:style.:extension",
                                                           :url => "/pictures/kids/:basename_:style.:extension",
                                                           :default_url => "/pictures/kids/dummy_:style.png"

 validates_attachment_content_type :picture, :content_type => ["image/bmp", "image/jpeg", "image/pjpeg", "image/jpg", "image/pjpg", "image/png", "image/x-png", "image/gif"], :message => "Du kannst hier nur Bilder (GIF, JPEG oder PNG) hochladen"

 validates_attachment_size :picture, :less_than => 4.megabyte, :message => "Das Bild kann höchstens 4 MB gross sein"

 validates_uniqueness_of :number, :message => "Diese Nummer ist bereits vergeben"

 validates_presence_of :firstname, :name, :number, :message => " darf nicht leer sein"

 named_scope :without_recent_letter, {:select => "kids.*", :joins => "JOIN letters_writtens ON letters_writtens.kid_id = kids.id", :conditions => "letters_writtens.received = '0' AND letters_writtens.letter_id = #{Letter.recent(1).last.id}" }

 named_scope :without_parent, {:select => "kids.*", :joins => "LEFT OUTER JOIN parentships ON parentships.kid_id = kids.id", :conditions => 'parentships.parent_id is NULL' }

 after_create :create_all_letters_written


 def recent_letters_written
   recent_letters = Letter.recent(2)

   recent_letters.collect{ |l|
     self.letters_written.find_by_letter_id(l)
     }.compact
 end

 def send_profile_to(receiver_email_array)
   receiver_email_array.each{ |r|
     KidsMailer.deliver_profile(r, self)
     }
 end

 def initialize(params ={})
   super
   self.number ||= (Kid.maximum(:number) || 0) + 1
 end

 def school=(school)
   visit = SchoolVisits.find_or_create_by_kid_id(id)
   visit.school = school
   visit.save!
 end

 def school_id= (school_id)
   visit = SchoolVisit.find_or_create_by_kid_id(id)
   visit.school_id = school_id
   visit.save!
 end

 def school_id
   school && school.id
 end

 def grade=(g)
   visit = SchoolVisit.find_or_create_by_kid_id(id)
   visit.grade = g
   visit.save!
 end

 def grade
   school_visit.present? ? school_visit.grade : ""
 end

 private

 def create_all_letters_written
   Letter.find(:all).each{ |l|
     LettersWritten.find_or_create_by_kid_id_and_letter_id_and_received(self.id, l.id, false)
   }
 end

 def self.most_recent_letter_id
    Letter.recent.last.id
 end

end
