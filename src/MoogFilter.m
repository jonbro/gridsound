/*
 *  MoogFilter.cpp
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/4/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "MoogFilter.h"

@implementation MoogFilter

@synthesize cutoff;
@synthesize res;

/*
 // input / ouput
 I - input sample
 L - lowpass output sample
 B - bandpass output sample
 H - highpass output sample
 N - notch output sample
 F1 - Frequency control parameter
 Q1 - Q control parameter
 D1 - delay associated with bandpass output
 D2 - delay associated with low-pass output
 
 //parameters:
 Q1 = 1/Q
 // where w1 goes from 2 to 0, ie Q goes from .5 to infinity
 
 // simple frequency tuning with error towards nyquist
 // F is the filter's center frequency, and Fs is the sampling rate
 F1 = 2*pi*F/Fs
 
 // ideal tuning:
 F1 = 2 * sin(pi * F / Fs)
 
 // algorithm
	// loop
	L = D2 + F1 * D1
	H = I - L - Q1*D1
	B = F1 * H + D1
	N = H + L
	
	// store delays
	D1 = B
	D2 = L
 
 
*/

-(id)init
{
	[super init];
	fs=44100.0;
    y1=y2=y3=y4=oldx=oldy1=oldy2=oldy3=0;
    [self calc];
	return self;
}

-(void)calc
{
	float f = (cutoff+cutoff) / fs; //[0 - 1]
	p=f*(1.8f-0.8f*f);
	k=p+p-1.f;
	
	float t=(1.f-p)*1.386249f;
	float t2=12.f+t*t;
	r = res*(t2+6.f*t)/(t2-6.f*t);
}

-(float)process:(float)input
{
	// process input
	x = input - r*y4;
	
	//Four cascaded onepole filters (bilinear transform)
	y1 = x*p +  oldx*p - k*y1;
	y2 = y1*p + oldy1*p - k*y2;
	y3 = y2*p + oldy2*p - k*y3;
	y4 = y3*p + oldy3*p - k*y4;
	
	//Clipper band limited sigmoid
	y4-=(y4*y4*y4)/6.f;
	
	oldx = x; oldy1 = y1; oldy2 = y2; oldy3 = y3;
	return y4;
}

@end