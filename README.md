# cbci-cluster-stuck-jobs
A Ruby tool for retrieving stuck jobs across a CloudBees CI Cluster

## Directions for Use
1. Ensure Ruby is installed.
2. Checkout this repo into a directory.
3. Navigate to the directory in CLI.
4. Run `bundle install` to install gems.
5. Run `ruby stuckJobs.rb`.
   1. Supply CJOC URL.
   2. Provide an administrative username.
   3. Provide password for the account.
6. Allow to complete run.

## Notice
This script is provided free of charge, without any warranty or guarantee of support. While it is tested against a CBCI Cluster (CI Modern in EKS Kubernetes), you're using this at your own risk!