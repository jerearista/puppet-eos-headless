# puppet-headless example for Arista EOS

## Setup

```
git clone https://github.com/jerearista/puppet-eos-headless.git puppet-headless
```

```
cd puppet-headless/
git submodule add https://github.com/arista-eosplus/puppet-eos.git modules/eos
git submodule status
git submodule init
```

## Usage

* Edit [scripts/puppet_update.sh](scripts/puppet_update.sh) to describe the method of syncing the repository to
  a switch.
* Bootstrap the switch(es) with 
  * Basic IP connectivity
  * eAPI enabled
  * extensions installed for
    * puppet (requires Ruby)
    * [rbeapi](https://github.com/arista-eosplus/rbeapi)
    * (optional) git, may be installed, if desired
  * Download [scripts/puppet_update.sh](scripts/puppet_update.sh) from this repo to the device
* Execute `puppet_update.sh` on the node to download the manifests and run `puppet_apply.sh` or simply use `puppet.sh` to do both.

# License

[License](LICENSE)

