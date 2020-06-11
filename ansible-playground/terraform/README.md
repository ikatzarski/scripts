## Prerequisites and Info

Terraform is used to generate AWS EC2 instances.

Use the EC2 instances as a playground to configure with Ansible.

Generate a ssh key pair to run Ansible and to ssh into the EC2 instances.

`main.tf` requires a ssh key

## SSH

#### Generate ssh key pair

```ssh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/ansible-slave -N ''
```

#### Change the files permissions of the key pair

```ssh
chmod 400 ~/.ssh/ansible-slave
chmod 400 ~/.ssh/ansible-slave.pub
```

#### SSH into an EC2 instance

```sh
ssh -i ~/.ssh/ansible-slave ubuntu@<public_dns/ip>
```
