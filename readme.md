# Packer Ansible provisioning demo. 

 This is a simple example of howto use packer with ansible and docker. 
 In this case the playbook install few dependencies and create a new images for a teamcity agent.
 

## Usage build an image
```
  make build  
```


## Usage clean
```
  make clean
```

## Note 
It is sad that we need to install Ansible with another provioner.
As expected the image contains new tools : gcc, nodejs etc.
