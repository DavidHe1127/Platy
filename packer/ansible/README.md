## Ansible

### Ansible as Packer Provisioner supports 2 strategies:

- ansible

Does not require `ansible` to be installed on the target - instance that's building AMI from. But it's required to be installed on the host machine.

- ansible-local

Requires `ansible` to be installed on the target. It does not need to be installed on the host. Run `shell` to install `ansible` prior to using ansible.

---

- Playbooks are run sequentially
- hosts example:

```yml
---
- hosts: aws
  tasks:
   - name: Install Nginx
     apt: pkg=nginx state=installed update_cache=true

# /etc/ansible/hosts:

[aws]
54.153.0.23
```
