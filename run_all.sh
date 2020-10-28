#!/bin/sh

echo "Spawning 10 processes"
for i in {1..10} ;
do
    ( matlab  -nodisplay -nodesktop -r "Main_Align_LFW(${i}, 'AFFINE'); exit" > "${i}.log" & )
done
