//
//  ballController.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/11/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "ballController.h"
#include "ofMain.h"

@implementation ballController
-(id)init
{
	[super init];
	width = 320;
	height = 320;
	[self reset];
	return self;
}
-(void)reset
{
	ballPos = Vector2f(width/2, height/2);
	accelPos = Vector2f(0.0, 0.0);
	velPos = Vector2f(0.0, 0.0);	
}
-(void)update
{
	accelPos.x = ofxAccelerometer.getForce().x;
	accelPos.y = -ofxAccelerometer.getForce().y; // lol everything is barkvards.
	velPos += accelPos*0.8;
	velPos *= 0.94;
	if(ballPos.y>height){
		ballPos.y = height-1;
		velPos.y = -velPos.y;
	}
	if(ballPos.y<0){
		ballPos.y = 1;
		velPos.y = -velPos.y;
	}
	if(ballPos.x<0){
		ballPos.x = 1;
		velPos.x = -velPos.x;
	}
	if(ballPos.x>width){
		ballPos.x = width-1;
		velPos.x = -velPos.x;
	}
	ballPos += velPos;	
}
-(void)render
{
//	ofSetColor(50, 50, 50);
//	ofRect(0, 0, width, height);
//	ofSetColor(255, 255, 255);
//	ofCircle(ballPos.x,ballPos.y, 10);
}
-(float)getX
{
	return ballPos.x/(float)width;
}
-(float)getY
{
	return ballPos.y/(float)height-0.5;
}
@end
