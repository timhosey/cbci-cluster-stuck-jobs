require 'userinput'

# Sets up input prompts for URL, username, and pass
clusterUri = UserInput.new(message: 'CBCI CJOC URL')
username = UserInput.new(message: 'CBCI Admin Username')
password = UserInput.new(message: 'CBCI Cluster Password', secret: true)

# Prompts user for input
clusterUri = clusterUri.ask
username = username.ask
password = password.ask

