#!/bin/bash
# Create yum-repos
echo "Create appstream.repo"
cat << EOF > /etc/yum.repos.d/appstream.repo
[AppStream]
name=Red Hat Enterprise Linux 9.5.0 - AppStream
baseurl=file:///mnt/cdrom/AppStream
enabled=1
gpgcheck=0
EOF

echo "Create baseos.repo"
cat << EOF > /etc/yum.repos.d/baseos.repo
[BaseOS]
name=Red Hat Enterprise Linux 9.5.0 - BaseOS
baseurl=file:///mnt/cdrom/BaseOS
enabled=1
gpgcheck=0
EOF

# Ordner anlegen
echo "Create folders"
mkdir -p /opt/sva/downloads /opt/sva/git /mnt/cdrom

# CDROM mounten und Subscription-Manager deaktivieren
echo "Disable Subscription Manager"
subscription-manager config --rhsm.manage_repos=0

echo "Mount CDROM"
mount -o loop /dev/sr0 /mnt/cdrom/

# Install ansible and git
echo "Install ansible and git"
dnf install -y ansible-core.x86_64 git

# Go to folder
echo "Go to git /opt/sva/git"
cd /opt/sva/git

# Clone repository
echo "Clone Repository"
git clone https://github.com/Patthecat249/install-sannav.git

# SSH-Key anlegen
echo "Create ssh-key"
ssh-keygen -t rsa -N ''

# ssh-copy-id 10.0.249.42