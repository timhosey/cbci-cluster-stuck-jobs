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

if (!File.exist?('./jenkins-cli.jar'))
  download = URI.open("#{cjocUri}/jnlpJars/jenkins-cli.jar")
  IO.copy_stream(download, './jenkins-cli.jar')
else
  puts "CLI Jar exists. Skipping..."
end

controllerJson = `java -jar jenkins-cli.jar -s #{cjocUri} -webSocket -auth #{username}:#{password} list-masters`
controllers = JSON.parse(controllerJson)

controllers['data']['masters'].each do |controller|
  puts "Processing Controller #{controller['fullName']}..."
  scriptExec = `java -jar jenkins-cli.jar -s #{controller['url']} -webSocket -auth #{username}:#{password} groovy = < ./lib/runningJobs.groovy`
end

# Delete the jar
# File.delete('./jenkins-cli.jar') if File.exist?('./jenkins-cli.jar')