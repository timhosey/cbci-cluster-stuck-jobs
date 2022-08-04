require 'userinput'
require 'open-uri'
require 'json'

# Sets up input prompts for URL, username, and pass
cjocUri = UserInput.new(message: 'CBCI CJOC URL')
username = UserInput.new(message: 'CBCI Admin Username')
password = UserInput.new(message: 'CBCI Cluster Password', secret: true)

# Prompts user for input
cjocUri = cjocUri.ask
username = username.ask
password = password.ask

# Puts a blank line
puts "\n"

# Check if CLI exists already
if (!File.exist?('./jenkins-cli.jar'))
  # Download CLI jar from CJOC
  download = URI.open("#{cjocUri}/jnlpJars/jenkins-cli.jar")

  # Save CLI jar
  IO.copy_stream(download, './jenkins-cli.jar')
else
  # Print skip message
  puts "CLI Jar exists. Skipping...\n\n"
end

# Runs CLI to get controllers on the cluster
controllerJson = `java -jar jenkins-cli.jar -s #{cjocUri} -webSocket -auth #{username}:#{password} list-masters`

# Parse JSON from CLI
controllers = JSON.parse(controllerJson)

# Loop controllers
controllers['data']['masters'].each do |controller|
  # Print name of controller
  puts "Processing Controller #{controller['fullName']}..."

  # Run CLI to hit groovy script
  scriptExec = `java -jar jenkins-cli.jar -s #{controller['url']} -webSocket -auth #{username}:#{password} groovy = < ./lib/runningJobs.groovy`

  # Print our execution result
  puts "#{scriptExec}\n"
end

# Delete the jar
File.delete('./jenkins-cli.jar') if File.exist?('./jenkins-cli.jar')