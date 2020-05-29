

1. Scale up by 2 times of current desired count with new AMI - new launch template
2. Find old instances with old AMI
3. Terminate them
4. Lifecycle capture terminate event and send message to SNS
5. SNS triggers lambda
6. Drain old instances - AWS will move tasks into new instances
7. Repeat check to see if outstanding tasks on old instance
  7.1 If no, then call asg to scale back down to original size. `OldestLaunchTemplate`
  7.2 If yes, call SNS to publish a message which triggers lambda itself again

