# Configure the TorqueBox Servlet-based session store.
# Provides for server-based, in-memory, cluster-compatible sessions
Transactions::Application.config.session_store :torquebox_store