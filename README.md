Rails app deployment to AWS with ansible and capistrano
===

Installation
---

Check [requirements](#prerequisites).

Get repository:

```
$ git clone https://github.com/dvps-task/simpleapp.git
```

Create ec2 instance:

```
$ cd simpleapp/ansible
$ ansible-playbook ruby-webapp.yml -c paramiko --ask-vault-pass
```

Update capistrano production config (_config/deploy/production.rb_):

```
$ vim ../config/deploy/production.rb
...
server "your_ec2_public_dns_name", user: "deploy", roles: %w{app web}
...
```

Move to the root directory of the repo and deploy rails app to aws:

```
$ capistrano production deploy
```
Check in the browser: _http://your_ec2_public_dns_name_

Prerequisites
---

Don't forget about ssh keys. Add ec2 and deploy ssh keys to ssh-agent or configure you ssh config file.

Place deploy public key into _ansible/roles/webserver/files/id_rsa_production.pub_.
