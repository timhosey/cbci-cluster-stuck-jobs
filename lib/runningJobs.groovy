import groovy.json.JsonOutput

def runningBuilds = Jenkins.instance.getView('All').getBuilds().findAll() { it.isInProgress() }
LinkedHashMap notificationPayload = [:]
runningBuilds.each{ value ->
  String jobName = value.getFullDisplayName()
  int durationInSeconds = (System.currentTimeMillis() - value.getStartTimeInMillis())/1000
  if (durationInSeconds > 30) {
    println("Job: ${jobName}, running for more than half a minute")
    println("Running time: " + durationInSeconds)
    notificationPayload.put(jobName, durationInSeconds + " sec")
  }
}