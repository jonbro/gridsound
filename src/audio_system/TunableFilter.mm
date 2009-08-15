//
//  TunableFilter.m
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TunableFilter.h"
#import "math.h"
@implementation TunableFilter

-(void) setCutoff:(int)_cutoff;
{
	cutoff = i2fp(_cutoff);
	[self calc];
}
-(void) setRes:(float)_res
{
	res = fl2fp(_res);
	[self calc];
}
-(void) calc
{
	sampleRate = 44100;
	//parameters:
	// where Q1 goes from 2 to 0, ie Q goes from .5 to infinity
	// simple frequency tuning with error towards nyquist
	// F is the filter's center frequency, and Fs is the sampling rate
	// get pi in here.
	//cutoff = 400;
	
	tunedCutoff = fl2fp(2.0*3.14159265358979323846264338327950288418*fp2fl(cutoff)/sampleRate);
	res = res;
	// ideal tuning:
	//F1 = 2 * sin(pi * F / Fs)
//	Delay1 = 0xFFFF/2;
//	Delay2 = 0xFFFF/2;
}
-(void)processSample:(Newfixed *)inputSample
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
	L = fp_add(Delay2,fp_mul(Delay1,tunedCutoff));
	H = fp_sub(fp_sub(*inputSample,L), fp_mul(res,Delay1));
	B = fp_add(fp_mul(tunedCutoff, H), Delay1);
	
//	N = H + L
	
	// store delays
	Delay1 = B;
	Delay2 = L;
	
	*inputSample = L;
}

@end
