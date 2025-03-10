#!/bin/bash
# Create yum-repos

cat << EOF > /etc/yum.repos.d/appstream.repo
[AppStream]
name=Red Hat Enterprise Linux 9.5.0 - AppStream
baseurl=file:///mnt/cdrom/AppStream
enabled=1
gpgcheck=0
EOF

cat << EOF > /etc/yum.repos.d/baseos.repo
[AppStream]
name=Red Hat Enterprise Linux 9.5.0 - BaseOS
baseurl=file:///mnt/cdrom/BaseOS
enabled=1
gpgcheck=0
EOF

# Ordner anlegen
mkdir -p /opt/sva/downloads /opt/sva/git /mnt/cdrom

# CDROM mounten und Subscription-Manager deaktivieren
subscription-manager config --rhsm.manage_repos=0
mount -o loop /dev/sr0 /mnt/cdrom/

# Install ansible and git
dnf install -y ansible-core.x86_64 git

# Go to folder
cd /opt/sva/git

# Clone repository
git clone https://github.com/Patthecat249/install-sannav.git

# SSH-Key anlegen
ssh-keygen -t rsa -N ''

# ssh-copy-id 10.0.249.192