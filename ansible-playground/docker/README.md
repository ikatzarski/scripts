## How to start?

#### Build the environment

```bash
docker-compose up -d
```

#### Bash into ans-controller

```bash
docker exec -it ans-controller /bin/bash
```

#### Generate public/private keypair on ans-controller and put the public key in the shared folder

```bash
ssh-keygen -N '' -f /root/.ssh/id_rsa && cp /root/.ssh/id_rsa.pub /tmp/shared
```

#### Bash into ans-host

```bash
docker exec -it ans-host /bin/bash
```

#### Start ssh service on ans-host and authorize the public key from the shared folder

```bash
service ssh start && mkdir /root/.ssh && cp /tmp/shared/id_rsa.pub /root/.ssh/authorized_keys
```

#### Check if ansible works on ans-controller

```bash
ansible playground -m ping -u root
```

Type `yes` and press `enter` when asked:

```bash
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

This will add the ssh key of ans-host to the known_hosts of ans-controller.

#### Run a sample ansible playbook

```bash
ansible-playbook -u root /tmp/shared/playbook.yml
```

#### Resources

More info on how to set up passwordless ssh:
- [1](https://www.linuxbabe.com/linux-server/setup-passwordless-ssh-login)
- [2](https://linuxize.com/post/how-to-setup-passwordless-ssh-login/)