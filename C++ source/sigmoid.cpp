#include <cmath>

float sigmoid(float x) {
	return 1.0 / (1.0 + exp(-x));
}