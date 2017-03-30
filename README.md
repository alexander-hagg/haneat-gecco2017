# haneat
Code release of "Evolving Parsimonious Networks by Mixing Activation Functions", March 2017, GECCO 2017

Contents:

Matlab implementation of NEAT, producing feed forward networks with heterogeneous activation functions.
This code will be extended to allow recurrent networks in the near future.

A demo.m script is provided, which includes a full experimental setup and saves the results to a binary file, 
which can be read in Matlab 

Abstract: 

Neuroevolution methods evolve the weights of a neural network, and in some cases the topology, but 
little work has been done to analyze the effect of evolving the activation functions of individual 
nodes on network size, which is important when training networks with a small number of samples.
In this work we extend the neuroevolution algorithm NEAT to evolve the activation function of neurons 
in addition to the topology and weights of the network. The size and performance of networks produced 
using NEAT with uniform activation in all nodes, or homogenous networks, is compared to networks which 
contain a mixture of activation functions, or heterogenous networks.
For a number of regression and classification benchmarks it is shown that, (1) qualitatively different 
activation functions lead to different results in homogeneous networks, (2) the heterogeneous version 
of NEAT is able to select well performing activation functions, (3) producing heterogeneous networks 
that are significantly smaller than homogeneous networks.
