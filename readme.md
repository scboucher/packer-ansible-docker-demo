# Packer Ansible provisioning demo. 

 This is a simple example of howto use packer with ansible and docker. 
 In this case the playbook install few dependencies and create a user.
 

## Usage
```
    packer build template.json
```


## Note 
It is sad that we need to install Ansible with another provioner.
As expected the image contains a user fedora and mysql, tmux, git are installed 