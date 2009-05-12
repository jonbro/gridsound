//
//  MoogFilter2.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/8/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "MoogFilter2.h"


@implementation MoogFilter2
-(id)init
{
	[super init];
	b0 = b1 = b2 = b3 = b4 = 0.0;  //filter buffers (beware denormals!)
	t1 = t2 = 0.0;              //temporary buffers
	lowPass = true;
	return self;
}	
-(void) setRes:(Float32)_res
{
	resonance = _res;
	[self calc];
}
-(void) setCutoff:(Float32)_cutoff
{
	_cutoff *= 2.0;
	if(_cutoff<1.0){
		cutoff = _cutoff;
		lowPass = true;
	}else{
		cutoff = _cutoff-1.0;
		lowPass = false;
	}
	cutoff = fmin(fmax(cutoff, 0.0), 1.0);
	[self calc];
}
-(void) calc
{
	q = 1.0f - cutoff;
	p = cutoff + 0.8f * cutoff * q;
	f = p + p - 1.0f;
	q = resonance * (1.0f + 0.5f * q * (1.0f - q + 5.6f * q * q));
}

-(void)processSample:(Float32 *)inputSample
{
	*inputSample -= q * b4;                          //feedback
	t1 = b1;  b1 = (*inputSample + b0) * p - b1 * f;
	t2 = b2;  b2 = (b1 + t1) * p - b2 * f;
	t1 = b3;  b3 = (b2 + t2) * p - b3 * f;
	b4 = (b3 + t1) * p - b4 * f;
	b4 = b4 - b4 * b4 * b4 * 0.166667f;    //clipping
	b0 = *inputSample;
	if(lowPass){
		*inputSample = b4;
	}else{
		*inputSample = *inputSample-b4;
	}
}

@end
