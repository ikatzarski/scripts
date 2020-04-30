## How to start?

#### Build the environment

```bash
docker-compose up -d
```

#### Bash into ans-master

```bash
docker exec -it ans-master /bin/bash
```

#### Generate public/private keypair on ans-master and put the public key in the shared folder

```bash
ssh-keygen -N '' -f /root/.ssh/id_rsa && cp /root/.ssh/id_rsa.pub /tmp/shared
```

#### Bash into ans-slave

```bash
docker exec -it ans-slave /bin/bash
```

#### Start ssh service on ans-slave and authorize the public key from the shared folder

```bash
service ssh start && mkdir /root/.ssh && cp /tmp/shared/id_rsa.pub /root/.ssh/authorized_keys
```

#### Check if ansible works on ans-master

```bash
ansible playground -m ping -u root
```

Type `yes` and press `enter` when asked:

```bash
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

This will add the ssh key of ans-slave to the known_hosts of ans-master.