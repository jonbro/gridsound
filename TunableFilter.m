//
//  TunableFilter.m
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TunableFilter.h"

@implementation TunableFilter

-(void) setCutoff:(float)_cutoff;
{
	cutoff = _cutoff;
	[self calc];
}
-(void) setRes:(float)_res
{
	res = _res;
	[self calc];
}
-(void) calc
{
	sampleRate = 44100.0;
	//parameters:
	// where Q1 goes from 2 to 0, ie Q goes from .5 to infinity
	// simple frequency tuning with error towards nyquist
	// F is the filter's center frequency, and Fs is the sampling rate
	// get pi in here.
	//cutoff = 400;
	tunedCutoff = 2.0*3.14*cutoff/sampleRate;
	res = res;
	// ideal tuning:
	//F1 = 2 * sin(pi * F / Fs)
//	Delay1 = 0xFFFF/2;
//	Delay2 = 0xFFFF/2;
}
-(void)processSample:(float *)inputSample
{
	/*
	 L = D2 + F1 * D1
	 H = I - L - Q1*D1
	 B = F1 * H + D1
	 N = H + L
	 
	 // store delays
	 D1 = B
	 D2 = L
	 */	 
	
	// loop
	L = Delay2 + tunedCutoff * Delay1;
	H = *inputSample - L - res*Delay1;
	B = tunedCutoff * H + Delay1;
	
//	N = H + L
	
	// store delays
	Delay1 = B;
	Delay2 = L;
	
	*inputSample = L;
}

@end
