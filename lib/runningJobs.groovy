import jenkins.model.Jenkins
import groovy.json.JsonOutput

def runningBuilds = Jenkins.instance.getView('All').getBuilds().findAll() { it.isInProgress() }
def count = 0
runningBuilds.each{ value ->
  String jobName = value.getFullDisplayName()
  int durationInSeconds = (System.currentTimeMillis() - value.getStartTimeInMillis())/1000
  if (durationInSeconds > 1800) {
    println("Job '${jobName}' running for " + durationInSeconds + " seconds")
    count++
  }
}

println(count + " jobs hanging.")