# LES of a turbulent channel flow: rotating, stratified case
Currently implementing:
* Smagorinsky LES closure scheme,
* rotation (user-defined Coriolis parameter),
* linear stratification (one-component buoyancy: temperature),
* velocity intialized with noise,
* doubly-periodic boundary conditions with solid wall, no-flux buoyancy boundaries on top and bottom

## How to run a simulation:
* If need to regenerate a new domain (i.e., after changes of boundary conditions or domain size):\
`$ $nekpath$/Nek5000/bin/genbox`\
when prompted type "turbChannel.box". After it runs, copy the generated file:\
`cp box.re2 turbChannel.re2`
* Compile:
`$ $nekpath$/Nek5000/bin/makenek turbChannel`\
$nekpath$: should refer a directory (if on ComputeCanada, home directory) where Nek5000 resides.
* Generate mesh:
`$ $nekpath$/Nek5000/bin/genmap`\
when prompted, type "turbChannel" and then "0.05"
* Run:
`$ $nekpath$/Nek5000/bin/nekmpi turbChannel num`\
num: number of cores used to run the simulation

## How to change boundary conditions and domain size (.box file)
* To edit the number of disrectized elements for each spatial dimension (x,y,z), change this line:\
<pre>
`-8  -256  -24                                     nelx,nely,nelz for Box`\
<\pre>
"-" in front of the number means that the elements are uniform size. If want non-uniform and wish to specify spacing, omit "-". Also, this is not the final resolution. Resolution of the simulation is each of these numbers multiplied by N, which is defined in SIZE file, i.e., here there are 8 elements in x-direction, which are then subdivided by N=8 (from SIZE), so the total number of grid cells in x-direction is 64 (and subsequently, 2048 grid cells in y and 192 in z).
* The actual domain size is specified in the next three lines:\
0 62.5 1.                                         x0,x1,ratio \
-1000 1000 1.                                     y0,y1,ratio\
-50 0  1.                                         z0,z1,ratio\
Here, the domain size is such that <img src="https://render.githubusercontent.com/render/math?math=x\in[0,62.5]">
