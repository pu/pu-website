# Automatically include our helper

ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES = ['jquery','jquery-ui','jrails', 'jquery_rails_ujs_helper']
ActionView::Helpers::AssetTagHelper::reset_javascript_include_default

ActionView::Base.send(:include, JqueryRailsUjsHelper)