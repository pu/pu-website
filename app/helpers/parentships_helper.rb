module ParentshipsHelper

  def kids_select_for_parentship
    Kid.find(:all, :order => "number DESC").collect{ |k| [ "#{k.number} #{k.firstname} #{k.name}", k.id] }
  end

  def parents_select_for_parentship
    Parent.find(:all, :order => "name").collect{ |p| ["#{p.name} #{p.firstname}", p.id] }
  end

end
