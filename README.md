# EII_LES
 Codes to run LES simulations for submesoscale frontal instabilities

## Pre-requisites
* Code requires Nek5000 software, which can be downloaded here: https://nek5000.mcs.anl.gov/
* Code requires to be run on a large number of cores (~100-300 cores), hence requiring supercomputing resources.
* Output can be post-processed either using the built-in Nek5000 functions or in Python (recommended)

## Contents
* turbChannel_LES: set-up with LES scheme (right now, Smagorinsky) for a non-rotating unstratified flow in a rectangular channel initialized with random noise
* rotChannel_LES: set-up with LES scheme (right now, Smagorinsky) for a rotating unstratified flow in a rectangular channel initialized with random noise
* RotStratChannel_LES: set-up with LES scheme (right now, Smagorinsky) for a rotating stratified flow in a rectangular channel initialized with random noise and linear background stratification
* Post-processing folder: contains all Python files for post-processing a Nek5000 output file, adapted from https://github.com/jcanton/pymech
