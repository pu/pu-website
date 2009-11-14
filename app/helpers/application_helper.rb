module ApplicationHelper
  
  def revision_string
    unless defined? @revision_string
      revision_file = File::join( RAILS_ROOT, 'REVISION' )
      @revision_string = if File.exists? revision_file
        File.open( revision_file ) do |file|
          file.readlines.first
        end
      end
    end
    @revision_string
  end
  
  def page_title(title = nil)
    if title == nil
      @page_title || "#{controller.controller_name}: #{controller.action_name}"
    else
      @page_title = title + " | Projekthilfe Uganda e.V."
    end
  end
  
end
