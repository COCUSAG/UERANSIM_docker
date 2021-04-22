### Prerequisites:
- docker and docker compose:
- before starting the container, make sure the gnb and ue config in .env is correct
- change network config in docker-compose.yaml
- **Be careful not to mess with other devices running in your network**
  - check which IP's you can use and add all other IP's to the aux_addresses section
    - you can use nmap to check for running hosts
    - e.g. `nmap -sP X.X.X.X/24`
```
networks:
  ueransim_vlan:
    driver: macvlan
    driver_opts:
    #network interface e.g. eno1
      parent: enx4865ee1f2d41
    ipam:
      driver: default
      config:
      #subnet you want to use
        - subnet: 10.3.2.1/24
          gateway: 10.3.2.254
          ip_range: 10.3.2.0/16
          aux_addresses:
          #addresses you don't want to assign to your container
            amf_ip: 10.3.2.191 
            blocker1: 10.3.2.1
```

### Simulate gNB's: 
# Building the container:
```
cd ~/5gransimulation
docker-compose build
```
# Starting the container:
```
docker-compose up --scale ueransim=<NumberOfgNBInstances>
```
- e.g. for 10 instances:
    - `docker-compose up --scale ueransim=10`
- the gNB IP is the ContainerIP

### Simulate UE's
- open `create_gnb_and_ue_session_for_container.sh`
    - edit 
        - NumberOfGNBInstances=<NumberOfgNBInstances>
        - NumberOfUEInstances=1 
            - UE's per gNB
        - UEsCreatedAtTheSameTime=1
        - UE_IMSI=001590001230010
- execute `create_gnb_and_ue_session_for_container.sh`

### Test UE's
- connect to a running container 
    - `docker exec -it <containerName> bash`
    - Test internet connectivity:
        - ping -I uesimtun0 <IP-Addr>
        - each UE hase a seperate usimtun interface
            - e.g. if you create 3 UE's for one container you have the following interfaces
            - uesimtun0
            - uesimtun1
            - uesimtun2

