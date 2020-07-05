## Custom AMI

- Run `provision.sh` to create an ec2 instance with Apache baked in
- Wait until instance is up and running and stop the instance
- [Create AMI image](https://docs.aws.amazon.com/toolkit-for-visual-studio/latest/user-guide/tkv-create-ami-from-instance.html)
- Run `destroy.sh` to remove stack

### Notes

- When you create an AMI image of your EC2 instance, EBS snapshots are created for each EBS volume attached to your EC2 instance. These EBS snapshots must persist as long as the AMI exists. But you can delete EBS volumes safely.
