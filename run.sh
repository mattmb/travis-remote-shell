#!/bin/bash

wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok.zip
apt-get update && apt-get install -y openssh-server
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd 
mkdir /var/run/sshd
mkdir /root/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCieu08YD9CMvhHBLigv0a/rf30kS4jRpldE+kJq6RGyNmZzlt6aVmXpQpxSCvi4o2Ivr7FYOG7+M6VXNCoMHmsZUGj2+rsvYaz/VXS2dFmvgKtVxOZkEJHKCjQtpL+4pk0App6IwlOCgL+Q+Ovotrzlyy9dfW31ZU4gFcrKjsWNcE8iwkWUeIIDL5q+QZ04tw1VytKb/9NwnmrbmKf2mgCAy5O3ISVHa5i0nEm7ni8gMwyyR6nHURisOMTVkvRq6Aea1S7dckPMuhn1SzP1homS/gR3l8DA2M7ols+W+R8YhY/03Bagqz39h1hsR5l5r9pEbEohnN43uNLGuPERBqQBiJTyU0jTC/PDZ//dosH6R5ssRsMnsWKk8Y7rmNjIQiRzu+X+fhscY91agBPKmrCNhmaoMuaR32TAz8mkM+8E3p/Ptv0ZPqs71WexpsRLUjuRPP19e30T7+iesQYghFHAWTOyonKfLwQa3yYoJQUmgbexNVjcy55vYd3Ae+kHft0rNHnpu9kB+MdlqwbstGhxufmGrOZ53YRz2aBQZpHiq9CFalD4izktLA1cgHOrRtK1MBk31Dy3ngI70cSevxm87umymEvZFc98d/Ex5VAsVp+QRwA+7aNHqZX60c8cbOdDGTXaHLJL9/8tgDy0erGsK/PpX+SnSG6rUpHtL5vlQ==' > /root/.ssh/authorized_keys 
cat /root/.ssh/id_rsa
chmod 700 /root/.ssh
chmod 600 /root/.ssh/*
/usr/sbin/sshd
{
    ./ngrok tcp 22 --authtoken=$NGROK_TOKEN --log=stdout --log-level=debug | grep "tcp.ngrok.io" || true
} &
for i in {0..20}; do
  sleep 5m
  echo "Doing something"
done
