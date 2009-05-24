//
//  parent_controller.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "parentController.h"
#include "ofMain.h"
#include "ofxAccelerometer.h"


parentControllerHelper::parentControllerHelper()
{		
	mainBackground.loadImage("bookbig2.jpg");
}

//--------------------------------------------------------------
parentControllerHelper::~parentControllerHelper()
{
	
}
void parentControllerHelper::drawBackground()
{
	ofSetColor(255, 255, 255);
	mainBackground.getTextureReference().draw(0, 0);
}

@implementation parentController

@synthesize children;
@synthesize instrumentGroup;

-(id) init;
{
	[super init];
	renderSmall = false;
	currentGrid = 0;
	children = [[NSMutableArray alloc]initWithCapacity:1];
	filtering = [[NSMutableArray alloc] initWithObjects:[[NSMutableString alloc] initWithString:@"false"], [[NSMutableString alloc] initWithString:@"false"], [[NSMutableString alloc] initWithString:@"false"], nil];
	currentState = [[NSMutableString alloc] initWithString:@"small"];
	y_offset = 0;
	x_offset = 0;
	target_y = 0;
	b_control = [[ballController alloc] init];
	target_x = 0;
	filter_on = false;
	scale = 1;
	pcHelper = new parentControllerHelper();
	target_scale = 1;
	return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:children forKey:@"children"];
	[coder encodeObject:currentState forKey:@"currentState"];
	[coder encodeObject:[[NSNumber alloc]initWithInt:currentGrid] forKey:@"currentGrid"];
}
- (id)initWithCoder:(NSCoder *)coder
{
    if (self != nil)
    {
		children = [coder decodeObjectForKey:@"children"];
		NSLog(@"children: %@", children);
		currentState = [coder decodeObjectForKey:@"currentState"];
		currentGrid = (int)[coder decodeObjectForKey:@"currentGrid"];
    }
    return self;
}
-(void)setPlayer:(RemoteIOPlayer *)_player
{
	player = _player;
}
-(void)render
{
	if([currentState isEqual:@"to_small"] || [currentState isEqual:@"to_large"] || [currentState isEqual:@"small"]){
		pcHelper->drawBackground();
		if(filter_on){
			[b_control render];
		}
	}else{
		[[children objectAtIndex:currentGrid] render];
	}

}
-(void)update
{
	if([currentState isEqual:@"to_small"] || [currentState isEqual:@"to_large"]){
		if(ofGetElapsedTimeMillis() < endTime+500){
			scale = [self tweenQuadraticCurrentTime:ofGetElapsedTimeMillis()-endTime startValue:1.0 valueChange:2.0 endTime_:500];
			x_offset = [self tweenQuadraticCurrentTime:ofGetElapsedTimeMillis()-endTime startValue:0 valueChange:target_x endTime_:500];
			y_offset = [self tweenQuadraticCurrentTime:ofGetElapsedTimeMillis()-endTime startValue:0 valueChange:target_y endTime_:500];
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
	if(filter_on){
		[b_control update];
		currentCutoff = [b_control getX];
		currentOffset = [b_control getY];
	}
	for(int i=0;i<3;i++){
		if([[filtering objectAtIndex:i] isEqual:@"true"]){
			[[instrumentGroup objectAtIndex:i] setCutoffDirect:currentCutoff];
			[[instrumentGroup objectAtIndex:i] setNoteOffset:currentOffset*4];
		}else{
			[[instrumentGroup objectAtIndex:i] setCutoffDirect:0.5];
			[[instrumentGroup objectAtIndex:i] setNoteOffset:0];
		}
	}
}
//tween linear
-(float)tweenLinearCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime_:(float)d
{
	return c*t/d + b;
}
// quadratic tween
-(float)tweenQuadraticCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime_:(float)d
{
	t /= d/2.0;
	if (t < 1) return c/2.0*t*t + b;
	return -c/2.0 * ((--t)*(t-2.0) - 1.0) + b;
}
-(void)addChild:(NSObject *)_child
{
	[children addObject:_child];
	[_child release];
}
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId{
//	NSLog(@"touchID: %i", touchId);
	if([currentState isEqual:@"large"]){
		if(x>275 && y>435){
			[currentState setString:@"to_small"];
			//set initial scale and offset
			x_offset = 0;
			y_offset = 0;
			scale = 1;
		}else{
			[[children objectAtIndex:currentGrid] touchDownX:x y:y touchId:touchId];
		}
	}else if([currentState isEqual:@"small"]){
		endTime = ofGetElapsedTimeMillis();
		for(int i=0;i<3;i++){
			for(int j=0;j<3;j++){
				if(
				   (int)x<(i+1)*111 &&
				   (int)x>i*111 &&
				   (int)y<(j+1)*111 &&
				   (int)y>j*111
				   ){
					if(j<2){
						[currentState setString:@"to_large"];
						//set target scale and offset
						target_y = -j*111;
						target_x = -i*111;
						target_scale = 2;
						currentGrid = j*3+i;
					}else{
						filter_on = true;
						[[filtering objectAtIndex:i] setString:@"true"];
					}
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
-(void)touchUpX:(float)x y:(float)y touchId:(int)touchId{
	for(int i=0;i<3;i++){
		[[filtering objectAtIndex:i] setString:@"false"];
		filter_on = false;
		[b_control reset];
	}
}

@end
