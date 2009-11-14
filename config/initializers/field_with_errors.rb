ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|  
  if html_tag =~ /<(input|textarea|select)/
    %(<span class=\"fieldWithErrors\">#{html_tag}</span>)
  else
    html_tag
  end
end