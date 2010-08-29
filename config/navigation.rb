# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|  
  # Specify a custom renderer if needed. 
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # navigation.renderer = Your::Custom::Renderer
  
  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  navigation.selected_class = 'selected'
  
  # Normally only the current sub menu is renderedwhen render_navigation is called
  # setting this to true render all submenus which is useful for javascript
  # driven hovering menus like the jquery superfish plugin
  # navigation.render_all_levels = true
  
  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    
    primary.item :home, 'Startseite', root_path, :class => 'startpage'
    primary.item :posts, 'Aktuelles', posts_path
    primary.item :projects, 'Projekte', projects_path
    primary.item :help_us, 'So können Sie helfen', page_path('so-koennen-sie-helfen') 
    # primary.item :pate, 'Fördermitglied', page_path('pate-werden') 
    # primary.item :members, 'Fördermitglied', page_path('foerdermitglied-werden') 
    # primary.item :donate, 'Spenden', page_path('spenden') 
    primary.item :about, 'Über uns', page_path('ueber-uns')
    
    # primary.item :contact, 'Impressum/Kontakt', page_path('kontakt')
    # primary.item :admin, 'Verwaltung', '/admin'
    
    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    
    # primary.dom_id = 'menu'
    primary.dom_class = 'navigation'
    
    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false
  
  end
  
end