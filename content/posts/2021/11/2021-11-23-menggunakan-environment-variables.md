+++
title = 'Menggunakan Environment Variables'
date = 2021-11-23T00:00:00Z
draft = false
categories = 'Server'
tags = ['Dasar Linux']
+++

Berbeda dengan _shell variables_ yang hanya dapat digunakan oleh shell, _environment variables_ dapat digunakan oleh shell dan program yang dijalankan dari shell tersebut.

Kita bisa mengubah shell variables menjadi environment variables menggunakan command *export*:
```
$ DB_NAME=testdb
$ export DB_NAME
$ env | grep DB_NAME
DB_NAME=testdb
```
Atau bisa juga langsung dalam satu line:
```
$ export DB_NAME=testdb
```

Untuk me-list seluruh environment variables, bisa menggunakan command *env*:
```
$ env
...output dipotong...
DB_NAME=testdb
MAIL=/var/spool/mail/redhat
PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/redhat/.local/bin:/home/redhat/bin
PWD=/home/redhat
LANG=en_US.UTF-8
SELINUX_LEVEL_REQUESTED=
HISTCONTROL=ignoredups
SHLVL=1
HOME=/home/redhat
...output dipotong...
```

## Setting variables secara otomatis
Kita bisa mengeset variables, baik shell atau environment variables secara otomatis ketika shell dijalankan dengan menggunakan Bash startup scripts. Ketika bash dijalankan, startup scripts tersebut akan dieksekusi untuk menginisialisasi shell environment.

Ada beberapa bash startup scripts yang dapat digunakan untuk mengkonfigurasi variables. Beberapa startup scripts itu akan dieksekusi atau tidak bergantung pada bagaimana shell di jalankan. Shell dapat dijalankan berupa _interactive login shell_, _interactive non-login shell_, atau _shell script_.

Sedangkan startup scripts yang dapat kita gunakan ada di:
- /etc/profile
- /etc/bashrc
- ~/.bash_profile
- ~/.bashrc

Sebagai contoh untuk mengeset default editor yang digunakan user tertentu, kita bisa mengeset variables EDITOR pada file ~/.bashrc:
```
$ vi ~/.bashrc

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export EDITOR=vi
```

## Menghapus variables
Untuk menghapus atau unset dan unexport variable, kita bisa menggunakan command _unset_:
```
$ env | grep DB_NAME
DB_NAME=testdb
$ echo $DB_NAME
testdb
$ unset DB_NAME
$ env | grep DB_NAME

$ echo $DB_NAME

```

Sedangkan untuk unexport variable tanpa unset, bisa menggunakan command _export -n_:
```
[redhat@rhel7-vm ~]$ export -n DB_NAME=testdb
[redhat@rhel7-vm ~]$ env | grep DB_NAME

[redhat@rhel7-vm ~]$ echo $DB_NAME
testdb
```

Catatan:
- Secara konvensi, shell dan environment variables yang diset otomatis oleh shell mempunyai nama UPPERCASE.
- Untuk mengubah setting yang ingin diaplikasikan untuk semua _user accounts_, cara yang umum digunakan adalah dengan membuat script dengan nama file berakhiran *.sh* di direktori */etc/profile.d*.