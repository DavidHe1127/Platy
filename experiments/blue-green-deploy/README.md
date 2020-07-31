## Blue and Green Deployment

Use weighted target group to implement B/G deployment.

### Workflow

- Create 2 target groups - one Blue and one Green for every app with Green one as standby.
- Direct 100% traffic to Blue target group
- When Green version is ready, deploy it using a different service name - i.e temperature-api-green and point it to Green target group
- Adjust weighted policy proportionally to distribute traffic to both groups

### Reference

[new-application-load-balancer-simplifies-deployment-with-weighted-target-groups/](https://aws.amazon.com/blogs/aws/new-application-load-balancer-simplifies-deployment-with-weighted-target-groups/)
