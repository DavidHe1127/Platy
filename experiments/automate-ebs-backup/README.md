## EC2 Data Lifecycle Manager

This is a test that demonstrates how DLM can be used to automate procedures of creating snapshots from selected EBS.
In this experiment, DLM looks for volumes tagged with `dockerzon-vol` and create snapshots from them according to specified rules.

### Notes

- Use `instance` as resource type to automate backup for all ebs attached to an ec2 instance
- Event will be emitted when a snapshot is being created. i.e `createSnapshot`. This allows you to setup lambda to listen for such event and trigger the lambda for notification purpose.

### Reference

- [DLM](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/snapshot-lifecycle.html#dlm-access-cmk)
