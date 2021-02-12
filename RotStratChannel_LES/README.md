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
`-8  -256  -24  nelx,nely,nelz for Box`\
"-" in front of the number means that the elements are uniform size. If want non-uniform and wish to specify spacing, omit "-". Also, this is not the final resolution. Resolution of the simulation is each of these numbers multiplied by N, which is defined in SIZE file, i.e., here there are 8 elements in x-direction, which are then subdivided by N=8 (from SIZE), so the total number of grid cells in x-direction is 64 (and subsequently, 2048 grid cells in y and 192 in z).
* The actual domain size is specified in the next three lines:\
`0 62.5 1.                                         x0,x1,ratio` \
`-1000 1000 1.                                     y0,y1,ratio`\
`-50 0  1.                                         z0,z1,ratio`\
Here, the domain size is such that <img src="https://render.githubusercontent.com/render/math?math=x\in[0,62.5],y\in[-1000,1000],z\in[-50,0]">. Ratio value of "1.0" makes the elements all the same size. If you want the elements graded (i.e., increase or decrease in size across a dimension), then change this value. For example, changing ratio value to "0.7" in y direction would make each successive element, going from left to right, 0.7 the size of the previous element (i.e., in this case, element size will decrease from left to right).
* Boundary conditions are specified in these lines:\
`P  ,P  ,P  ,P  ,W  ,W                             vel bc's(3 chars each!)`\
`P  ,P  ,P  ,P  ,I  ,I  				  temp/buo BCs`
Here, "P" stands for periodic, "W" for wall (i.e., no-slip), and "I" for insulated (i.e., zero flux). All boundary conditions need to be 3 characters each, so for one-letter denominations, need to add two spaces. Free-slip boundary conditions are "SYM". Adding wind-stress to be discussed.

## Changing parameters, run time (in .par file)
* Change end time of simulation (either in terms of simulation time or number of time steps) and the interval for checkpoint saving (also in terms of simulation run time or number of time steps)
* Change initial time step size (I suggest keeping "variableDt = yes" which will decrease time step if CFL condition is not met)
* If restarting simulation from checkpoint, uncomment and change:\
`startFrom = restart_filename`\
* Change values for user-defined parameters (which are used in .usr file subroutines), namely, Coriolis parameter, turbulent Prandtl number (needed for LES scheme of buoyancy field), and Richardson number (needed for adding stratification in non-dimensionalized Navier-Stokes solved by the code)
* Change "viscosity" value, which is basically 1/Re (Re: Reynolds number)
* Change "conductivity" value, which is viscosity/Pr (Pr: Prandtl number, different from turbulent Prandtl number)

## Changing initial conditions, LES scheme, wind boundary conditions (in .usr file)
* Takes in user-defined values from .par file (can define new ones if necessary)
* Going over different subroutines:
  * **subroutine uservp** (do not change):\
     defines viscosity (small scale + LES closure scheme, i.e. <img src="https://render.githubusercontent.com/render/math?math=\nu_tot = \nu+\nu_{LES}">) and similarly diffusivity (small scale + LES closure scheme, i.e. <img src="https://render.githubusercontent.com/render/math?math=\kappa_tot = \kappa+\nu_{LES}/Pr_t">), where <img src="https://render.githubusercontent.com/render/math?math=\nu,\kappa"> are defined as "viscosity" and "conductivity" in .par file and <img src="https://render.githubusercontent.com/render/math?math=Pr_t"> is user-defined turbulent Prandtl number (also defined in .par file)
