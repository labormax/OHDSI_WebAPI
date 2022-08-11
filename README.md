# OHDSI WebAPI

OHDSI WebAPI contains all OHDSI RESTful services that can be called from OHDSI applications.

## Features

- Provides a centralized API for working with 1 or more databases converted to the [Common Data Model](https://github.com/OHDSI/CommonDataModel) (CDM) v5.
- Searching the OMOP standardized vocabularies for medical concepts and constructing concept sets.
- Defining cohort definitions for use in identifying patient populations.
- Characterizing cohorts
- Computing incidence rates
- Retrieve patient profiles
- Design population level estimation and patient level prediction studies

## Technology

OHDSI WebAPI is a Java 8 web application that utilizes a database (PostgreSQL, SQL Server or Oracle) for storage.

## System Requirements & Installation

Documentation can be found a the [Web API Installation Guide](https://github.com/OHDSI/WebAPI/wiki) which covers the system requirements and installation instructions.

## SAML Auth support

The following parameters are used:

- `security.saml.idpMetadataLocation=classpath:saml/dev/idp-metadata.xml` - path to metadata used by identity provider
- `security.saml.metadataLocation=saml/dev/sp-metadata.xml` - service provider metadata path
- `security.saml.keyManager.keyStoreFile=classpath:saml/samlKeystore.jks` - path to keystore
- `security.saml.keyManager.storePassword=nalle123` - keystore password
- `security.saml.keyManager.passwords.arachnenetwork=nalle123` - private key password
- `security.saml.keyManager.defaultKey=apollo` - keystore alias
- `security.saml.sloUrl=https://localhost:8443/cas/logout` - identity provider logout URL
- `security.saml.callbackUrl=http://localhost:8080/WebAPI/user/saml/callback` - URL called from identity provider after login

Sample idp metadata and sp metadata config files for okta:
- `saml/dev/idp-metadata-okta.xml`
- `saml/dev/sp-metadata-okta.xml`

## Managing auth providers

The following parameters are used to enable/disable certain provider:

- `security.auth.windows.enabled`
- `security.auth.kerberos.enabled`
- `security.auth.openid.enabled`
- `security.auth.facebook.enabled`
- `security.auth.github.enabled`
- `security.auth.google.enabled`
- `security.auth.jdbc.enabled`
- `security.auth.ldap.enabled`
- `security.auth.ad.enabled`
- `security.auth.cas.enabled`

Acceptable values are `true` and `false`

## Geospatial support

Instructions can be found at [webapi-component-geospatial](https://github.com/OHDSI/webapi-component-geospatial)

## IRIS support

In order to run Atlas through your IRIS OMOP database:
1. Clone repositories 
- OHDSI_IRIS_WebAPI
- OHDSI_IRIS_PostgreSQL
- OHDSI_IRIS_Achilles
- OHDSI_IRIS_Atlas
2. Run Achilles SQL scripts on your database in IRIS terminal:
- do $SYSTEM.SQL.Schema.ImportDDL("OHDSI_IRIS_Achilles/ddlAchillesMySQL/01-prepare-for-webapi.sql",,"MySQL")
- do $SYSTEM.SQL.Schema.ImportDDL("OHDSI_IRIS_Achilles/ddlAchillesMySQL/02-achilles.sql",,"MySQL")
3. Configure your IRIS server path and credentials in OHDSI_WebAPI/src/main/resources-iris/db/migration/postgresql/V9.9.9__artificial_dataset.sql
   (Please note that if your IRIS server is on local PC you should address it as host.docker.internal)
4. From OHDSI_IRIS_WebAPI folder run:
- docker-compose build
- docker-compose up
  Building and starting may take long time depending on the performance of host computer
5. Atlas will be available here http://127.0.0.1:8081/atlas/

## Testing

It was chosen to use embedded PG instead of H2 for unit tests since H2 doesn't support window functions, `md5` function, HEX to BIT conversion, `setval`, `set datestyle`, CTAS + CTE.

## Support

- Developer questions/comments/feedback: [OHDSI forum](http://forums.ohdsi.org/c/developers)
- We use the [GitHub issue tracker](https://github.com/OHDSI/WebAPI/issues) for all bugs/issues/enhancements.

## Contribution

### Versioning

- WebAPI follows [Semantic versioning](https://semver.org/);
- Only Non-SNAPSHOT dependencies should be presented in POM.xml on release branches/tags.

## License
OHDSI WebAPI is licensed under Apache License 2.0