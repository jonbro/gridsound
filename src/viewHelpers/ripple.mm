//
//  ripple.m
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/21/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "ripple.h"

@implementation ripple

@synthesize x;
@synthesize y;
@synthesize scale;

-(id)init
{
	[super init];
	self.x = 0;
	self.y = 0;
	currentState = [[NSMutableString alloc] initWithString:@"static"];
	return self;
}
-(void)startPulse
{
	[currentState setString:@"pulse1"];
	startTime = ofGetElapsedTimeMillis();
	endTime = ofGetElapsedTimeMillis()+100.0;
}
-(void)update
{
	if([currentState isEqual:@"pulse1"]){
		scale = [self tweenLinearCurrentTime:ofGetElapsedTimeMillis()-startTime startValue:0 valueChange:1 endTime_:150];
		if(ofGetElapsedTimeMillis()>endTime){
			[currentState setString:@"pulse2"];
			startTime = ofGetElapsedTimeMillis();
			endTime = ofGetElapsedTimeMillis()+300.0;
		}
	}
	if([currentState isEqual:@"pulse2"]){
		scale = [self tweenLinearCurrentTime:ofGetElapsedTimeMillis()-startTime startValue:1 valueChange:-1 endTime_:300];
		if(ofGetElapsedTimeMillis()>endTime){
			[currentState setString:@"static"];
		}
	}
}
-(void)renderX:(float)_x Y:(float)_y
{
	ofEnableAlphaBlending();
	if(![currentState isEqual:@"static"]){
		ofSetColor(255, 0, 0, 80);
		ofCircle(_x, _y, self.scale*20);
	}
	ofSetColor(255, 255, 255, 255);
}
-(float)getScale
{
	if(![currentState isEqual:@"static"]){
		return scale;
	}else{
		return 0;
	}
}
-(float)tweenLinearCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime_:(float)d
{
	return c*t/d + b;
}
@end
