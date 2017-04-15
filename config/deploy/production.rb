server "node1",
  user: "vagrant",
  roles: %w{app web},
  ssh_options: {
    keys: %w(/home/vagrant/.ssh/id_rsa_ansible),
    forward_agent: false,
    auth_methods: %w(publickey)
  }


