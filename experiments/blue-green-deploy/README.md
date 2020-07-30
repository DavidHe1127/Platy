## Blue and Green Deployment

Use weighted target group to implement B/G deployment.

### Workflow

- Create 2 target groups for every app with one of the two as standby.
- Direct 100% traffic to target group in usage (Blue)
- Deploy green versioned of app to standby target group when b/g takes place
- Adjust weighted policy to proportionally route traffic to blue and green groups

### Reference

[new-application-load-balancer-simplifies-deployment-with-weighted-target-groups/](https://aws.amazon.com/blogs/aws/new-application-load-balancer-simplifies-deployment-with-weighted-target-groups/)


