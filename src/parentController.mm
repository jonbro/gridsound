//
//  parent_controller.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "parentController.h"
#include "ofMain.h"

@implementation parentController

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
		[[children objectAtIndex:currentGrid] touchDownX:x y:y touchId:touchId];
		if(x>285 && y>453){
			renderSmall = true;
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
