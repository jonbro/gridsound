// fixed point numbers

#include "fixed.h"

#ifdef USE_FIXED_POINT
Newfixed fl2fp(float val) {
	return (Newfixed)(val * FIXED_SCALE);
}

float fp2fl(Newfixed val) {
	return ((float)val) / FIXED_SCALE;
}
#endif

