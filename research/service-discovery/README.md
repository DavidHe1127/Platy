### Service Discovery

Service Discovery allows services deployed on different container instances to see and communicate with each other. It keeps state of your services along with their connection info (ip/port/etc.) would need to be stored in a third party datastore of some sort which gets constantly updated.

It's a mechanism and can be implemented in several ways. i.e via DNS using Route53.

You don't need it if tasks are defined within the same task definition as they can communicate through the bridge network that's created by docker when executing docker compose file.

