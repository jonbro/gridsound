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
	return self;
}
-(void)render
{
	if(renderSmall){
//		NSEnumerator *enumerator = [children objectEnumerator];
//		id object;
//		while ((object = [enumerator nextObject])) {
//			[object render];
//		}
		for(int i=0;i<3;i++){
			for(int j=0;j<2;j++){
				ofSetColor(0xEB008B);
				ofFill();
				ofRect(111*i, 111*j, 98, 98);
			}
		}
	}else{
		[[children objectAtIndex:currentGrid] render];
	}
}
-(void)addChild:(NSObject *)_child
{
	[children addObject:_child];
}
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId{
	if(!renderSmall){
		if(x>275 && y>435){
			renderSmall = true;
		}else{
			[[children objectAtIndex:currentGrid] touchDownX:x y:y touchId:touchId];
		}
	}else{
		for(int i=0;i<3;i++){
			for(int j=0;j<2;j++){
				if(
				   (int)x<(i+1)*111 &&
				   (int)x>i*111 &&
				   (int)y<(j+1)*111 &&
				   (int)y>j*111
				   ){
					renderSmall = false;
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
