## SSL

We use AWS ACM to issue and manage cert to enable https for our app.

After run the script, you also need to go to your cert detail page and click the button `Create record in Route 53` to complete domain validation.

### ACM

- It supports wildcard domain names - you need only one cert for your root domain and subdomains. Without wildcard supports will need you to create a cert for each domain.
- Use DNS as domain validation method - this will need you to create a CNAME record in your DNS config. ACM present `push button` option for you to create the record if you use route 53 to manage your DNS config under same account as ACM.
- It automatically renews deployed cert as long as CNAME record remains in your DNS configuration
