# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tog_demo_session',
  :secret      => 'b0ad2ef2ffdfdaf6d3526acbf47e19ac7fc5faf3fde07bd05b4003b886f635edabcade43f8b9fc070493dc83731e057982cadc231f93f3fd02123a032e141f46'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
