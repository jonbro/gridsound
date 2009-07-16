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
	//mainBackground.loadImage("bookbig2.jpg");
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
	y_offset = 0;
	x_offset = 0;
	target_y = 0;
	b_control = [[ballController alloc] init];
	target_x = 0;
	filter_on = false;
	scale = 1;
	wallHelper = new wallFolderHelper();
	target_scale = 1;
	return self;
}
-(void)setPlayer:(RemoteIOPlayer *)_player
{
	player = _player;
}
-(void)render
{
	if([[model valueForKey:@"currentState"] isEqual:@"to_small"] || [[model valueForKey:@"currentState"] isEqual:@"to_large"] || [[model valueForKey:@"currentState"] isEqual:@"small"]){
		if(wallHelper->zoomingSecondary || wallHelper->zooming){
			[[children objectAtIndex:[model.currentGrid intValue]] render];
		}
		wallHelper->drawWall();
		for(int i=0;i<3;i++){
			if([[model.mutes objectAtIndex:i]boolValue]){
				wallHelper->drawMute(i);
			}
		}
	}else{
		[[children objectAtIndex:[model.currentGrid intValue]] render];
	}

}
-(void)update
{
	if([[model valueForKey:@"currentState"] isEqual:@"to_small"] || [[model valueForKey:@"currentState"] isEqual:@"to_large"]){
		if(!wallHelper->zooming && !wallHelper->zoomingSecondary){
			if([[model valueForKey:@"currentState"] isEqual:@"to_small"]){
				model.currentState = @"small";
			}else{
				model.currentState = @"large";
			}
		}
	}else if([[model valueForKey:@"currentState"] isEqual:@"large"] || wallHelper->zoomingSecondary){
		[[children objectAtIndex:[model.currentGrid intValue]] update];
	}
	if(filter_on){
		[b_control update];
		currentCutoff = [b_control getX];
		currentOffset = [b_control getY];
		wallHelper->setBalloon([b_control getUnscaledX], [b_control getUnscaledY]);
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
-(void)setModel:(parentModel *)_model
{
	[model release];
	model = [_model retain];
	for(int i=0;i<[model.gridModels count];i++){
		[[children objectAtIndex:i] setModel:[model.gridModels objectAtIndex:i]];
		[[children objectAtIndex:i] setParentModel:model];
	}
}
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId{
	if([[model valueForKey:@"currentState"] isEqual:@"large"]){
		// clicking on the exit button
		if(x>236 && y>386){
			model.currentState = @"to_small";
			wallHelper->zoomFromBook([model.currentGrid intValue]);
			[[children objectAtIndex:[model.currentGrid intValue]] hideBelt];
		}else{
			[[children objectAtIndex:[model.currentGrid intValue]] touchDownX:x y:y touchId:touchId];
		}
	}else if(y>370 && y<460 && [[model valueForKey:@"currentState"] isEqual:@"small"] && !wallHelper->info && !wallHelper->help){
		for(int i=0;i<3;i++){
			if(
				(int)x<(i+1)*107 &&
				(int)x>i*107
			){
				wallHelper->openWall();
				filter_on = true;
				[[filtering objectAtIndex:i] setString:@"true"];				
			}
				
		}
	}else if([[model valueForKey:@"currentState"] isEqual:@"small"]){
		if(wallHelper->infoTransition){
			//do nothing!!!
		}else if(wallHelper->help){
			wallHelper->fromHelp();
		}else if(wallHelper->info){
			// back button
			if(x>37&&y>62&&x<119&&y<96){
				wallHelper->fromInfo();
			}
			// lucky frame link
			if(x>257&&y<319&&y>247){
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.luckyframe.co.uk"]];
			}
			if(y>244&&y<315){
				if(x>91&x<128){
					// book help (1)
					wallHelper->toHelp(1);
				}else if(x>176&&x<231){
					// bug help (0)
					wallHelper->toHelp(0);
				}
			}
		}else{
			// TEST FOR MUTES.
			if(y>12&&y<84){
				if(x>27&&x<101){
					[model.mutes replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:![[model.mutes objectAtIndex:0]boolValue]]];
				}
				if(x>127&&x<200){
					[model.mutes replaceObjectAtIndex:1 withObject:[NSNumber numberWithBool:![[model.mutes objectAtIndex:1]boolValue]]];
				}
				if(x>226&&x<300){
					[model.mutes replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:![[model.mutes objectAtIndex:2]boolValue]]];
				}			
			}
			// TEST FOR INFO
			if(x<32&&y>217&&y<296){
				wallHelper->toInfo();
			}
			// TEST FOR BOOKS.
			if(x>42&&x<99&&y>103&&y<190){
				model.currentGrid = [NSNumber numberWithInt:0];
				[self bookSelected];
			}
			if(x>137&&x<196&&y>103&&y<190){
				model.currentGrid = [NSNumber numberWithInt:1];
				[self bookSelected];
			}
			if(x>238&&x<296&&y>103&&y<190){
				model.currentGrid = [NSNumber numberWithInt:2];
				[self bookSelected];
			}
			if(x>55&&x<110&&y>227&&y<314){
				model.currentGrid = [NSNumber numberWithInt:3];
				[self bookSelected];
			}
			if(x>140&&x<194&&y>227&&y<314){
				model.currentGrid = [NSNumber numberWithInt:4];
				[self bookSelected];
			}
			if(x>226&&x<284&&y>227&&y<314){
				model.currentGrid = [NSNumber numberWithInt:5];
				[self bookSelected];
			}
		}
	}
}
-(void)bookSelected
{
	model.currentState = @"to_large";
	wallHelper->zoomToBook([model.currentGrid intValue]);
}
-(void)doubleTapX:(float)x y:(float)y touchId:(int)touchId
{
	if([[model valueForKey:@"currentState"] isEqual:@"large"]){
		[[children objectAtIndex:[model.currentGrid intValue]] doubleTapX:x y:y touchId:touchId];
	}
}
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId{
	if([[model valueForKey:@"currentState"] isEqual:@"large"]){
		[[children objectAtIndex:[model.currentGrid intValue]] touchMoved:x y:y touchId:touchId];
	}
}
-(void)touchUpX:(float)x y:(float)y touchId:(int)touchId{
	if([[model valueForKey:@"currentState"] isEqual:@"large"]){
		[[children objectAtIndex:[model.currentGrid intValue]] touchUp:x y:y touchId:touchId];
	}else{
		for(int i=0;i<3;i++){
			[[filtering objectAtIndex:i] setString:@"false"];
			wallHelper->closeWall();
			filter_on = false;
			[b_control reset];
		}
	}
}

@end
