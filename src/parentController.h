//
//  parentController.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gridController.h"
#include "ofMain.h"
#import "RemoteIOPlayer.h"
#include "ofxiPhoneKeyboard.h"
#import "ballController.h"
#import "parentModel.h"

class parentControllerHelper 
	{		
	public:
		parentControllerHelper();
		~parentControllerHelper();
		void drawBackground();
	protected:		
		ofImage mainBackground;
	};


@interface parentController : NSObject {
	bool renderSmall, filter_on;
	int currentGrid;
	float y_offset, x_offset, scale, target_y, target_x, target_scale; // lol, should move this shit into vectors
	float endTime;
	float currentCutoff, currentOffset;
	ballController *b_control;
	parentControllerHelper *pcHelper;
	NSMutableArray *instrumentGroup;
	parentModel *model;
	RemoteIOPlayer	*player;
	NSMutableString *currentState;
	NSMutableArray	*children;
	NSMutableArray	*filtering;
}

@property (nonatomic, retain) NSMutableArray *instrumentGroup;
@property (assign) NSMutableArray* children;

-(void)render;
-(void)setPlayer:(RemoteIOPlayer *)_player;
-(void)setModel:(parentModel *)_model;
-(void)update;
-(void)addChild:(NSObject *)_child;
-(float)tweenQuadraticCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime_:(float)d;
-(float)tweenLinearCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime_:(float)d;
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUpX:(float)x y:(float)y touchId:(int)touchId;

@end
