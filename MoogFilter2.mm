//
//  MoogFilter2.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/8/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "MoogFilter2.h"


@implementation MoogFilter2

-(void) setRes:(Float32)_res
{
	resonance = _res;
	[self calc];
}
-(void) setCutoff:(Float32)_cutoff
{
	cutoff = _cutoff;
	[self calc];
}
-(void) calc
{
	q = fp_sub(fl2fp(1.0f),cutoff);
	p = fp_add(cutoff, fp_mul(fp_mul(fl2fp(0.8f), cutoff), q));
	f = fp_sub(fp_add(p, p), FP_ONE);
	q = fp_mul(resonance, fp_mul(fp_mul(fp_add(FP_ONE, fl2fp(0.5f)), q), fp_mul(fp_mul(fp_add(fp_sub(FP_ONE, q), fl2fp(5.6f)), q), q)));
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
	
	*inputSample = b4;
	// Lowpass  output:  b4
	// Highpass output:  in - b4;
	// Bandpass output:  3.0f * (b3 - b4);
}

@end
