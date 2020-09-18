# Changelog
All notable changes to the Solr configuration for our Blacklight application will be documented in this file. The Solr configuration for our blacklight application contains the "Solr Schema" which is the basic configuration that defines the datatypes that will be ingested and queried.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and releases in blacklight_solr_conf project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Removed
- Removed subtitle_t, subtitle_display, and subtitle_vern_display references [PR#5](https://github.com/ualbertalib/blacklight_solr_conf/pull/5)

### Added
- Added the ability to search by a cancelled isbn [PR#6](https://github.com/ualbertalib/blacklight_solr_conf/pull/6)
- Added the ability to search by a invalid issn [PR#7](https://github.com/ualbertalib/blacklight_solr_conf/pull/7)
- Added the ability to search by oclc number [PR#8](https://github.com/ualbertalib/blacklight_solr_conf/pull/8)
