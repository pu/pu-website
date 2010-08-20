module CacheExpiryHelper

  def expire_all_caches
    Kid.all.each{ |k|
      expire_view_cache_for_kid(k)
      }
  end

  def expire_view_cache_for_kid(kid)
    expire_fragment(:key => "kids_row#{kid.id}")
    kid.parentships.each{|p| expire_fragment(:key => "parentships_row_#{p.id}")}
    kid.parents.each{|p| expire_fragment(:key => "parents_row_#{p.id}")}
  end

  def expire_view_cache_for_parent(parent)
    expire_fragment(:key => "parents_row#{parent.id}")
    parent.parentships.each{|p| expire_fragment(:key => "parentships_row_#{p.id}")}
    parent.kids.each{|k| expire_fragment(:key => "kids_row_#{k.id}")}
  end

  def expire_view_cache_for_parentship(parentship)
    # This chould be model code, but conceptually it copes with views and caching
    expire_fragment(:key => "kids_row#{parentship.kid.id}")
    expire_fragment(:key => "parents_row#{parentship.parent.id}")
    expire_fragment(:key => "parentships_row_#{parentship.id}")
  end
end
