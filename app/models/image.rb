class Image < ActiveRecord::Base

  before_create :randomize_file_name
    
  belongs_to :uploadable, :polymorphic => true
  
  acts_as_list :scope => :uploadable
  
  attr_accessor :data
    
  has_attached_file :data,
    :styles => {
      # :tiny => ["30x30#", :jpg], # user log, last visitors
      :small => ["60x60#", :jpg], # e.g. LoginBox, comments
      :medium => ["90x90#", :jpg], # e.g. ImageSlider
      :overview => ["120x120#", :jpg], # e.g. profile overviews, friends
      # :profile => ["140x140#", :jpg], # e.g. profile image
      :preview => ["150x150#", :jpg], # e.g. asset overview
      # :news_preview => ["200x200#", :jpg], #not necessary here, because they're created in backend only
      :lightbox => ['480x', :jpg], # e.g. big preview image in news
      :full => ["800x600>", :jpg] # e.g. lightbox full view
    },
    :default_style => :overview,
    :default_url => '/images/dummies/:account_type_dummy_:style.:extension',
    :convert_options => {
      :all => "-strip"
    },
    #:rounded => 7,
    :path => ":rails_root/public/:test_envassets/:id_partition/:random_name_:style.:extension",
    :url => "/:test_envassets/:id_partition/:random_name_:style.:extension",
    :whiny => true

  validates_attachment_presence :data, :message => 'muss ausgewählt werden.'
  validates_attachment_size :data, :less_than => 5.megabytes, :message => 'darf nicht größer als 5MB sein.'
  validates_attachment_content_type :data, :content_type => [
                                              'image/jpeg', 'image/png', 'image/gif', "image/pjpeg", 
                                              "image/x-png", "image/x-tiff", "image/tiff", "image/bmp", "image/x-windows-bmp" 
                                              ], :message => 'hat kein erlaubtes Bildformat. Nur jpg, png, gif, tiff und bmp sind erlaubt.',
                                              :if => :required?
    
  
  def required?
    # disable content type matching in test env because an image is of type text/plain there
    ENV['RAILS_ENV'] != 'test'
  end
  
  def randomize_file_name
    extension = self.data_file_name.scan(/\.\w+$/).to_s.downcase
    self.data_file_name = "#{generate_unique_id}#{extension}"
  end
  
  def url(*args)
    data.url(*args)
  end
  
  def name
    data_file_name
  end
  
  def filename
    data_file_name
  end
  
  def content_type
    data_content_type
  end
  
  def randomize_file_name
    logger.debug "Asset: #{self.inspect}"
    extension = self.data_file_name.scan(/\.\w+$/).to_s.downcase
    self.data_file_name = "#{generate_unique_id}#{extension}"
  end
  
  def browser_safe?
    %w(jpg gif png).include?(url.split('.').last.downcase)
  end
  alias_method :web_safe?, :browser_safe?
  
  # This method will replace one of the existing thumbnails with an file provided.
  def replace_style(style, file)
    style = style.downcase.to_sym
    if data.styles.keys.include?(style)
      if File.exist?(RAILS_ROOT + '/public' + a.data(style))
      end
    end
  end
  
  # This method assumes you have images that corespond to the filetypes.
  # For example "image/png" becomes "image-png.png"
  def icon
    "#{data_content_type.gsub(/[\/\.]/,'-')}.png"
  end
    
  # def detach(account)
  #   a = self.find(:first, :conditions => ["account_id = ? AND account_type = ?", account, account.class.to_s])
  #   raise ActiveRecord::RecordNotFound unless a
  #   a.destroy
  # end
  
  private
  def generate_unique_id(length = 16)
    ActiveSupport::SecureRandom.hex(length)
  end
end

# change path and url while in test environment
Paperclip.interpolates :test_env do |attachment, style|
  RAILS_ENV == "test" ? "test/" : ""
end

Paperclip.interpolates :random_name do |attachment, style|
   attachment.instance.data_file_name.scan(/^(\w+)\./).to_s.downcase
end
