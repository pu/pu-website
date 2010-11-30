module CacheExpiryHelper

  def expire_all_caches
    Kid.all.each{ |k|
      expire_view_cache_for_kid(k)
      }
  end

  def expire_view_cache_for_kid(kid)
    expire_fragment("kids_row_#{kid.id}")
    kid.parentships.each{|p| expire_fragment("parentships_row_#{p.id}")}
    kid.parents.each{|p| expire_fragment("parents_row_#{p.id}")}
  end

  def expire_view_cache_for_parent(parent)
    expire_fragment("parents_row_#{parent.id}")
    parent.parentships.each{|p| expire_fragment("parentships_row_#{p.id}")}
    parent.kids.each{|k| expire_fragment("kids_row_#{k.id}")}
  end

  def expire_view_cache_for_parentship(parentship)
    # This chould be model code, but conceptually it copes with views and caching
    expire_fragment("kids_row_#{parentship.kid.id}")
    expire_fragment("parents_row_#{parentship.parent.id}")
    expire_fragment("parentships_row_#{parentship.id}")
  end
end
