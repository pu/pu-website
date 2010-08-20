# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Normally only the current sub menu is renderedwhen render_navigation is called
  # setting this to true render all submenus which is useful for javascript
  # driven hovering menus like the jquery superfish plugin
  navigation.render_all_levels = true

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :dashboard, 'Übersicht', admin_path
    primary.item :pages, 'Seiten', admin_pages_path
    primary.item :posts, 'Artikel', admin_posts_path

    primary.item :administration, 'Verwaltung', newsletters_path do |secondary|
      secondary.item :kids, 'Kinder', kids_path
      secondary.item :kids, 'Kinder ohne Paten', kids_without_parent_path
      secondary.item :kids, 'Fehlende Briefe', kids_without_letter_path
      secondary.item :parents, 'Paten', parents_path
      secondary.item :parents, "Paten - Adressliste", address_index_parents_path
      secondary.item :parentships, 'Patenschaften', parentships_path
      secondary.item :schools, 'Schulen', schools_path
      secondary.item :letters, 'Kinderbriefe', letters_path
      secondary.item :newsletters, 'Newsletter', newsletters_path

    end

    # primary.item :users, 'Users', admin_users_path

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    primary.dom_class = 'sf-menu'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end
