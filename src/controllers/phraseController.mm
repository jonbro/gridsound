//
//  phrase_controller.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "phraseController.h"


@implementation phraseController

@synthesize loading;

-(id)init
{
	self = [super init];
	
	backButton = [[GLButton alloc] initWithFrame:CGRectMake(0, 180, 90, 90)];
	backButton._delegate = self;
	backButton.visible = false;
	[self addSubview:backButton];

	phraseSet = [[NSMutableArray alloc] initWithCapacity:0];
		
	loading = true;
	phraseButtons = [[NSMutableArray alloc] initWithCapacity:0];
	for(int i=0; i<14;i++){
		int x_offset = 0;
		int y_offset = 0;
		int button_height = 0;
		int button_width = 0;
		GLButton *phrase_button = [[GLButton alloc] init];
		phrase_button._delegate = self;
		if(i<2){
			x_offset = 150;
			button_width = 61;
			button_height = 99;
			phrase_button.frame = CGRectMake(x_offset+button_width*i, 0, button_width, button_height);
		}else if(i<5){
			x_offset = 61;
			button_width = 70;
			button_height = 81;
			phrase_button.frame = CGRectMake(x_offset+button_width*(i-2), 99, button_width, button_height);
		}else if(i<6){
			x_offset = 92;
			button_width = 39;
			button_height = 90;
			phrase_button.frame = CGRectMake(x_offset, 180, button_width, button_height);			
		}else if(i<8){
			x_offset = 131;
			button_width = 70;
			button_height = 90;
			phrase_button.frame = CGRectMake(x_offset+button_width*(i-6), 180, button_width, button_height);
		}else if(i<11){
			x_offset = 61;
			button_width = 70;
			button_height = 90;
			phrase_button.frame = CGRectMake(x_offset+button_width*(i-8), 271, button_width, button_height);
		}else{
			x_offset = 61;
			button_width = 70;
			button_height = 83;
			phrase_button.frame = CGRectMake(x_offset+button_width*(i-11), 361, button_width, button_height);
		}
		[phraseButtons addObject:phrase_button];
		[self addSubview:phrase_button];
	}
	return self;
}
-(void)buttonDidPress:(GLButton *)_button
{
	if(backButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToMenu" object:self];
	}
	if(loading){
		if(_button == clearPhrase){
			parentModel *pModel = [bankC loadParent:0];
			if(pModel != nil){
				[parentC setModel:pModel];
			}
		}
	}else{
		[bankC saveParent:parentC.model atIndex:0];
	}
}
-(void)setBankController:(bankController*)_bankC
{
	[bankC release];
	bankC = [_bankC retain];
	
}
-(void)setParentController:(parentController*)_parentC
{
	[parentC release];
	parentC = [_parentC retain];
}
-(void)render
{
	wallHelper->drawRect(0, 0, 320, 480, 256, 384, 0, 384, 2);
	[super render];
}

@end
