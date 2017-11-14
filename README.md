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
