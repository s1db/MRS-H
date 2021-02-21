# Spin commands (assume file is workers1.pml)

Normal verification to check for deadlock (i.e. invalid end states):

```
  workers1.pml

gcc -DMEMLIM=1024 -O2 -DXUSAFE -DSAFETY -DNOCLAIM -w -o pan pan.c
./pan -m10000
```
## Check for non-progress:

```
spin -a  workers1.pml

gcc -DMEMLIM=1024 -O2 -DXUSAFE -DNP -DNOCLAIM -w -o pan pan.c
./pan -m10000  -l 
```

## Check an LTL property:

```
spin -a  workers1.pml
gcc -DMEMLIM=1024 -O2 -DXUSAFE -w -o pan pan.c
./pan -m10000  -a
```
run a guided simulation (assuming that workers1.pml.trail has been generated)

```
spin -p -s -r -X -v -n123 -l -g -k workers1.pml.trail -u10000 workers1.pml
```

run a random simulation. You can change the seed -here it is 123, and you can change the maximum search depth (here it is 10000). 

```
spin -p -s -r -X -v -n123 -l -g -u10000 workers1.pml
```