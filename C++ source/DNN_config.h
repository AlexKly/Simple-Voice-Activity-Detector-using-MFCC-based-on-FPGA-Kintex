#pragma once
#ifndef DNN_config_H
#define CNN_congif_H

#include <cmath>

// Constants:
#define MFCC_SIZE 39
#define HIDDEN_NODES_SIZE_1 128
#define HIDDEN_NODES_SIZE_2 64
#define HIDDEN_NODES_SIZE_3 32
#define HIDDEN_NODES_SIZE_4 16

// Prototypes:
float ReLU(float);
float sigmoid(float);
int DNN(float mfcc[MFCC_SIZE]);

#endif
