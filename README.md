# tfscaffold example
A very simple example of using Terraform with AWS, with a codebase organised around the [tfscaffold](https://github/tfutils/tfscaffold) tool.

Terraform State is stored remotely in a private s3 bucket, setup using the tfscaffold bootstrap process.

This codebase supports being scaled up to multiple environments, consisting of multiple components, with any duplication minimised by locally defined modules.

Typically a project's infrastructure would be logically grouped into a small set of components such as:
* *base* - has no depenedencies, contains resources such as DNS, network, and any other "core" infrastructure
* *data* - depends upon the *core* component, contains resources such as databases, NoSQL datastores, caches, storage, etc
* *application* - depends upon the *data* component, contains resources such as servers/containers/functions, code deployments, api gateways/web front end access, etc

The component grouping helps to separate frequently changing resources from rarely changing ones, and to minimise the circumstance where Terraform needs to destroy resources because it has decided a dependent resource needs recreating. Any dependencies between components should be handled using output variables.

## Code Structure
* *bin* - The tfscaffold wrapper script, do not edit
* *bootstrap* - The tfscaffold remote state resources, do not edit 
* *components* - Put your components here
* *etc* - The environment-specific settings to use. Extract out any common values at a higher level, e.g. at region, group or global levels. To create a new environment, just create another *env* file
* *lib* - Useful for pipelines
* *modules* - Put your local modules here
* *plugin-cache* - Cached providers, exclude from version control

## Use
Setup your local AWS CLI access, e.g. `AWS_PROFILE`, and keep all access details out of your Terraform codebase and not under version control.

See the tfscaffold documentation on bootstrapping remote state first.

To run a TF plan:

`./bin/terraform.sh -p <project> -r <region> -e <env> -c <component> -a plan`

To run a TF apply:

`./bin/terraform.sh -p <project> -r <region> -e <env> -c <component> -a apply`

## Versions Used
* Terraform v1.4.6
* tfscaffold v1.7.0
* AWS provider v5.1.0
* AWS CLI v2.11.25

## Limitations
For simplicity this example will run in a single AWS account, using only free tier resources.

For a non-trivial project, look at using AWS Organisations, a hierarchy of separate accounts (e.g. to control dev, test and prod data access) each containing one or more environments, and some suitable service control policies to set some mandatory guard rails about what may or may not be used, and where. Hold the IaC and code artefacts and pipelines in a dedicated account that has permissions and access to provision environments in all other accounts, ideally from scratch.

This can scale up to a single department with several technical teams working on several projects/products/services with the same ways of working.

For large organisations with dedicated InfoSec operations teams, and a large number of technical teams working in several business departments using a range of approaches (so optional guardrails become necessary), look at using AWS Control Tower.