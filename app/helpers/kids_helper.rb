module KidsHelper

  def school_select_for_kids
    School.find(:all).collect{ |s| [ "#{s.name}", s.id] }
  end
  
end
