# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_uganda_session',
  :secret      => '37d266a7fcbdbadc3a0a5d49bd0d83003dcfc33ddba2f6b1bd5d66d60d3bf45077970ab9378ee0aaaec34ec8ababf0720d31c3853300de1b57c304e26663f10f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
