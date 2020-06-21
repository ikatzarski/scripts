## Info

`main.tf` generates two AWS EC2 instances. They can be used as a playground to configure with Ansible.

`main.tf` and `ansible-playground` require a ssh key.

## SSH

#### Generate ssh key pair

```ssh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/ansible-host -N ''
```

#### Change the files permissions of the key pair

```ssh
chmod 400 ~/.ssh/ansible-host
chmod 400 ~/.ssh/ansible-host.pub
```

#### SSH into an EC2 instance

```sh
ssh -i ~/.ssh/ansible-host ubuntu@<public_dns/ip>
```

## Ansible

#### Setup ansible inventory

Copy Host1 and Host2's public DNS from the `terraform apply` output.

Replace `<ansible-ubuntu-host-1 public dns>` and `<ansible-ubuntu-host-2 public dns>` in `inventory.yml` with the relevant public DNS.

#### Run ansible playbook

```sh
cd ansible

ansible-playbook --private-key ~/.ssh/ansible-host -i inventory.yml playbook.yml
```
