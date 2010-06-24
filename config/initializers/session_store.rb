# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nameaband_session',
  :secret      => '9a4e7dc390bcbe02f5940653b96ecb6888cac656ef5e5875c294ac8b12c5924a28d62142bec85f35befc5541d010203c7724befaaaadbac182efefc082e9ad7a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
