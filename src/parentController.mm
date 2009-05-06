//
//  parent_controller.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "parentController.h"
#include "ofMain.h"

@implementation parentController

@synthesize children;

-(id) init;
{
	[super init];
	renderSmall = false;
	currentGrid = 0;
	children = [[NSMutableArray alloc]initWithCapacity:1];
	currentState = [[NSMutableString alloc] initWithString:@"small"];
	y_offset = 0;
	x_offset = 0;
	target_y = 0;
	target_x = 0;
	scale = 2;
	target_scale = 1;
	return self;
}
-(void)render
{
	if([currentState isEqual:@"to_small"] || [currentState isEqual:@"to_large"] || [currentState isEqual:@"small"]){
		for(int i=0;i<1;i++){
			for(int j=0;j<1;j++){
				ofSetColor(0xEB008B);
				ofFill();
				int width = (int)((float)98)*scale;
				ofRect(111*i+x_offset, 111*j+y_offset, width, ((float)98)*scale);
			}
		}
	}else{
		[[children objectAtIndex:currentGrid] render];
	}

}
-(void)update
{
	if([currentState isEqual:@"to_small"] || [currentState isEqual:@"to_large"]){
		if(ofGetElapsedTimeMillis() < endTime){
			scale = [self tweenCurrentTime:(float)ofGetElapsedTimeMillis() startValue:-1.0f valueChange:2.0f endTime:endTime];
			NSLog(@"startTime = %f\n", endTime);
		}else{
			scale = 1;
			if([currentState isEqual:@"to_small"]){
				[currentState setString:@"small"];
			}else{
				[currentState setString:@"large"];
			}
		}
	}else if([currentState isEqual:@"large"]){
		[[children objectAtIndex:currentGrid] update];
	}
}

// quadratic tween
-(float)tweenCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime:(float)d
{
	t /= d/2;
	if (t < 1) return c/2*t*t + b;
	return -c/2 * ((--t)*(t-2) - 1) + b;
}


-(void)addChild:(NSObject *)_child
{
	[children addObject:_child];
	[_child release];
}
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId{
	if([currentState isEqual:@"large"]){
		if(x>275 && y>435){
			[currentState setString:@"to_small"];
			//set initial scale and offset
			target_y = 0;
			target_x = 0;
			target_scale = -2;
		}else{
			[[children objectAtIndex:currentGrid] touchDownX:x y:y touchId:touchId];
		}
	}else if([currentState isEqual:@"small"]){
		endTime = ofGetElapsedTimeMillis() + 2000;
		for(int i=0;i<3;i++){
			for(int j=0;j<3;j++){
				if(
				   (int)x<(i+1)*111 &&
				   (int)x>i*111 &&
				   (int)y<(j+1)*111 &&
				   (int)y>j*111
				   ){
					[currentState setString:@"to_large"];
					//set target scale and offset
					target_y = -j*111;
					target_x = -i*111;
					target_scale = 2;
					currentGrid = j*3+i;
				}
			}
		}
	}
}
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId{
	if(!renderSmall){
		[[children objectAtIndex:currentGrid] touchDownX:x y:y touchId:touchId];
	}	
}
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId{
}

@end
