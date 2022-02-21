1. Add the IP address of the server to the appropriate hosts file, e.g. `inventories/production/hosts`.

2. Run the appropriate playbooks, for example:

```shell
ansible-playbook -i playbooks/cloud/inventories/production/hosts playbooks/cloud/cloud.yml
```

## Linting

`ansible-lint` will load custom `.yamllint` config files, extending its internal `yamllint` config.
