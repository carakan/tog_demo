# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tog_demo_session',
  :secret      => '525f7e2229bb64f3212f4c66ec500ebdf37e5f66054bb70fbe070141d1ce0cab187a6c4a85a5a2ad762ae770fc261bbcf923ce8de10da1b0df44c2dda0ad17f2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
