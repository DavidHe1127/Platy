## SSL

We use AWS ACM to issue and manage cert to enable https for our app.

### ACM

- It supports wildcard domain names - you need only one cert for your root domain and subdomains. Without wildcard supports will need you to create a cert for each domain.
- Use DNS as domain validation method - this will need you to create a CNAME record in your DNS config. This process is automatic if you use Route53 in the same AWS account to manage DNS records.
- It automatically renews deployed cert as long as CNAME record remains in your DNS configuration
