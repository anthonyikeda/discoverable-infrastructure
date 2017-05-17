Running Consul
---

Currently the servers are not configured to start when launched in Vagrant and must be started by:

# Log in to the individual machines
# Execute the start up

```bash
$ vagrant ssh n1
vagrant@n1:$ consul agent -config-dir=/etc/consul.d
==> WARNING: Bootstrap mode enabled! Do not enable unless necessary
==> Starting Consul agent...
==> Consul agent running!
```

Running Nomad
---
Like the Consul servers, Nomad is not started when the virtual machines are started and must be started manually:

```bash
$ vagrant ssh nomad1
ubuntu@nomad1:$ nomad agent -config=/etc/nomad.d
==> WARNING: Bootstrap mode enabled! Potentially unsafe operation.
    Loaded configuration from /etc/nomad.d/config.hcl
==> Starting Nomad agent...
...
==> Nomad agent started! Log data will stream in below:
```

Vault
---

Now let's get Vault running!

```bash
$ vault server -config=/etc/vault.d
```
