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
  
  def boolean_icon_path( b )
    b ? "/images/admin/success.gif" : "/images/admin/error.gif"
  end
  
end
