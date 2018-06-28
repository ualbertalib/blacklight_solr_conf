# blacklight_solr_conf
Solr configuration for our Blacklight application

In short, the Discovery application doesn't exist in a vacuum -- it allows administrators to ingest data from Symphony, 
SFX, and 'databases' into SolrCloud, and allow students, staff, and other users to query it via the web front-end.  This repository
contains the "Solr Schema" -- the basic configuration that defines the datatypes that will be ingested and queried.  Solr uses
this schema as a template for the data, making searching and faceting possible.

How is this repository used?
The typical workflow (under auspices of a change request) is:
- Sam is responsible for making changes to this schema
- Neil will package any updates, into the discovery-solrconf RPM (use rotherham as buildserver)
- In Test: 
  - Neil will build a new RPM, load it onto the testcustom6 RPM repo
  - Neil will use the playbook under ansible-config/projects/solrcloud_collections/ to apply the new RPM, and load the new schema 
  into zookeeper
  - Neil will use the same playbook to create a new collection, based on the new schema
  - Neil will likely also update the application code needed to work with this new schema (Sam modifies code, Neil package + install)
  - Neil will populate the new collection with data
  - Neil will adjust the alias, from the old collection, to the new collection
  - Neil will delete the old collection

In the Production environment, we might need to do a staged rollout, eg taking york out of the HAProxy pool, so it can populate
new collections (under new schema) with new data, while the other two servers continue to serve requests from the old collection.
Once the new collection is complete, we can apply code updates to the other two servers, and swing the alias over to have all
the application servers use the new collection. 

Also, the NEOSDiscovery application uses the same SolrCloud collection, via alias... so consider whether that code needs updating
at the same time as the Discovery environment, and dovetail any plans to update!

About Tagging This Repository:
I guess it would be convenient if the RPM version of this code matched an appropriate version of Discovery.
But be aware: Discovery suffers revisions much more frequently, than this repo.  There will be significant lag between versions.

Why a separate repo?
At the inception of the Discovery project, the files inside this repo were buried within the Discovery repo. Neil split them out, 
to facilitate RPM-based distribution.  And to prevent Sam from accidentally updating the schema, without telling me.

# Docker image for UAL Discovery/NEOS Discovery Solr


## What is this?

This image can be used as a Solr datastore for [UAL Discovery](https://github.com/ualbertalib/discovery) and [NEOS Discovery](https://github.com/ualbertalib/neosdiscovery). This image is built on the [Solr 6.6 image](https://hub.docker.com/_/solr/) and adds the configuration files required to create collections. This is necessary because the configuration lives in a seperate repository to the application.

## Requirements


Ensure you have [Docker (1.13.0+)](https://docs.docker.com/engine/installation/) and 
[Docker Compose (1.10.0+)](https://docs.docker.com/compose/install/) installed


## In this Docker Container

In the Docker Container are the minimum dependencies to run Solr with this projects schema and configurations available in the /myconfig directory.


## Usage

Expected usage is with Docker Compose `docker-compose up -d` which can use the entrypoints
provided by the solr container to create any collections
desired (discovery_test, etc).

[Developer Handbook Docker Usage Section](https://github.com/ualbertalib/Developer-Handbook/tree/master/Docker#docker-usage)

### Updating Docker Hub

* Image will be updated using hooks upon merge to the master branch of [this project](https://github.com/ualbertalib/blacklight_solr_conf)
* Find us on [Docker Hub](https://hub.docker.com/r/ualbertalib/blacklight_solr_conf/)

### Upgrading local container

Expected usage is with Docker Compose `docker-compose pull` which will seek out the latest
image from Docker Hub.

See [Developer Handbook Updating the local container](https://github.com/ualbertalib/Developer-Handbook/tree/master/Docker#updating-local-container)

## Frequently used commands

See [Developer Handbook](https://github.com/ualbertalib/Developer-Handbook/tree/master/Docker#frequently-used-commands)

## Special notes / warnings / gotchas




## Future considerations

To capture any proposed future work or future considerations.
