#!/bin/bash

NumberOfGNBInstances=1
NumberOfUEInstances=1
UEsCreatedAtTheSameTime=1
UE_IMSI=001590001230010
ContainerName=5gransimulation_ueransim_


for ((i=1;i<=NumberOfGNBInstances;i++));
do    
   echo "Start $NumberOfUEInstances UE instances"
   UEsCreated=0
   for((j=0; j<=NumberOfUEInstances;j+UEsCreatedAtTheSameTime))
   do
        docker exec $ContainerName$i ./build/nr-ue -c config/ue.yaml -i $UE_IMSI -n $UEsCreatedAtTheSameTime&
        UE_IMSI=$((UE_IMSI+UEsCreatedAtTheSameTime))
        UEsCreated=$((UEsCreated+UEsCreatedAtTheSameTime))

        sleep 2
    done
done
echo "all UEs started"

