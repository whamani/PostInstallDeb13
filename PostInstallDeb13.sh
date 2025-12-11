#!/usr/bin/env bash

#==================================================================#
#Install BinUtils et NetBIOS:
#==================================================================#

apt update && apt upgrade -y
apt install ssh zip nmap locate ncdu curl git screen dnsutils net-tools sudo lynx winbind samba -y

#==================================================================#
# Personnalisation du nsswitch.conf:
#==================================================================#

echo "
# /etc/nsswitch.conf
#
# Example configuration of GNU Name Service Switch functionality.
# If you have the 'glibc-doc-reference' and 'info' packages installed, try:
# 'info libc "Name Service Switch"' for information about this file.

passwd:         files systemd
group:          files systemd
shadow:         files systemd
gshadow:        files systemd

hosts:          files dns wins
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis" > /etc/nsswitch.conf

#==================================================================#
#Personnalisation du Bashrc:
#==================================================================#

echo "
# ~/.bashrc: executed by bash(1) for non-login shells.
# Note: PS1 is set in /etc/profile, and the default umask is defined
# in /etc/login.defs. You should not need this unless you want different
# defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
#cexport LS_OPTIONS='--color=auto'
# eval "$(dircolors)"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

export LS_OPTIONS='--color=auto'
eval LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42>
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias l='ls --color=auto -lA' " >> /root/.bashrc

#==================================================================#
# Install Webmin
#==================================================================#

curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh

sh webmin-setup-repo.sh --force

apt install -y webmin --install-recommends
#==================================================================#
echo "End"
#==================================================================#

reboot
