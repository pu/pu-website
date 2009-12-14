class LettersWritten < ActiveRecord::Base
  
  belongs_to :kid
  belongs_to :letter
  
end
