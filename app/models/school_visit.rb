class SchoolVisit < ActiveRecord::Base
  
  belongs_to :kid
  belongs_to :school
  
end
