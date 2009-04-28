//
//  TunableFilter.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 // where Q1 goes from 2 to 0, ie Q goes from .5 to infinity
 
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


@interface TunableFilter : NSObject {
	float cutoff;
	float res;
	float sampleRate;
	float tunedCutoff;
	float Delay1, Delay2;
	float L, H, B;
}

-(void) setCutoff:(float)_cutoff;
-(void) setRes:(float)_res;
-(void) calc;
-(void)processSample:(float *)inputSample;

@end
