//
//  MoogFilter2.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/8/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//  http://www.musicdsp.org/showone.php?id=25

#include "fixed.h"

@interface MoogFilter2 : NSObject {
	Float32 f, p, q, cutoff, resonance;             //filter coefficients
	Float32 b0, b1, b2, b3, b4;  //filter buffers (beware denormals!)
	Float32 t1, t2;              //temporary buffers
	bool lowPass;
}

-(void)setCutoff:(float)_cutoff;
-(void)setRes:(float)_res;
-(void)calc;
-(void)processSample:(Float32 *)inputSample;

@end