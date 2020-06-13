## Info

`main.tf` generates two AWS EC2 instances. They can be used as a playground to configure with Ansible.

`main.tf` and `ansible-playground` require a ssh key.

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

## Ansible

#### Setup ansible inventory

Copy Slave1 and Slave2's public DNS from the `terraform apply` output.

Replace `<ansible-ubuntu-slave-1 public dns>` and `<ansible-ubuntu-slave-2 public dns>` in `inventory.yml` with the relevant public DNS.

#### Run ansible playbook

```sh
cd ansible

ansible-playbook --private-key ~/.ssh/ansible-slave -i inventory.yml playbook.yml
```
