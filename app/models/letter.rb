class Letter < ActiveRecord::Base
  attr_accessible :name, :due_date
  
  has_many :letters_written
  
  after_create :create_letters_written_for_all_kids 
  
  
  def self.recent(limit = 2)
    Letter.find(:all, :order => "due_date DESC", :limit => limit)
  end
  
  private
  
  def create_letters_written_for_all_kids
    Kid.find(:all).each{ |k|
      LettersWritten.find_or_create_by_kid_id_and_letter_id_and_received(k.id, self.id, false)
    }
  end
end
