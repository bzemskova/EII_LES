# LES of a turbulent channel flow: rotating, stratified case
Currently implementing:
* Smagorinsky LES closure scheme,
* rotation (user-defined Coriolis parameter),
* linear stratification (one-component buoyancy: temperature),
* velocity intialized with noise,
* doubly-periodic boundary conditions with solid wall, no-flux buoyancy boundaries on top and bottom

## How to run a simulation:
* Compile:
~/Nek5000/bin/makenek turbChannel
~/Nek5000: should refer a directory (if on ComputeCanada, home directory) where Nek5000 resides.
* Generate mesh:
~/Nek5000/bin/genmap
when prompted, type "turbChannel" and then "0.05"
* Run:
~/Nek5000/bin/nekmpi turbChannel num
num: number of cores used to run the simulation
