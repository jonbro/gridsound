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
	
	toDialog = false;
	atDialog = false;
	
	backButton = [[GLButton alloc] initWithFrame:CGRectMake(0, 180, 90, 90)];
	backButton._delegate = self;
	backButton.visible = false;
	[self addSubview:backButton];
	
	confirm = [[GLButton alloc] initWithFrame:CGRectMake(32, 261, 129, 73)];
	confirm._delegate = self;
	confirm.visible = false;
	[self addSubview:confirm];
	
	cancel = [[GLButton alloc] initWithFrame:CGRectMake(161, 261, 120, 73)];
	cancel._delegate = self;
	cancel.visible = false;
	[self addSubview:cancel];
	
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
		phrase_button.visible = false;

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
	if(!toDialog && !atDialog){
		for(int i=0; i<[phraseButtons count];i++){
			if(_button == [phraseButtons objectAtIndex:i]){
				if(loading){
					parentModel *pModel = [bankC.bModel.phraseSet objectForKey:[NSNumber numberWithInt:i]];
					if(pModel != nil){
						[parentC setModel:[pModel copy]];
						fadeStart = ofGetElapsedTimeMillis();
						jar_to_load = i;
						tweenDirection = true;
						tweening = true;
					}
				}else{
					dialogStart = ofGetElapsedTimeMillis();
					direction = 1;
					jar_to_save = i;
					dialog_pos = 1;
					toDialog = true;
				}
			}
		}
	}
	if(atDialog){
		if(_button == confirm){
			[bankC.bModel.phraseSet setObject:[parentC.model copy] forKey:[NSNumber numberWithInt:jar_to_save]];
			direction = 0;
			dialogStart = ofGetElapsedTimeMillis();
			toDialog = true;
			atDialog = false;
		}
		if(_button == cancel){
			direction = 0;
			dialogStart = ofGetElapsedTimeMillis();
			toDialog = true;
			atDialog = false;
		}
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
	float sizeScale = 0.8;
	wallHelper->drawRect(0, 0, 320, 480, 256, 384, 0, 384, 2);
	if(bankC.bModel.phraseSet != nil){
		for(int i=0; i<[phraseButtons count];i++){
			if([bankC.bModel.phraseSet objectForKey:[NSNumber numberWithInt:i]] != nil){
				GLButton *this_button = [phraseButtons objectAtIndex:i];
				CGRect buttonFrame = this_button.frame;
				wallHelper->drawRect(buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.size.width, buttonFrame.size.height, round(buttonFrame.size.width*sizeScale), round(buttonFrame.size.height*sizeScale), round(256+(buttonFrame.origin.x*sizeScale)), round(384+(buttonFrame.origin.y*sizeScale)), 2);
			}
		}
	}
	if(loading){
		wallHelper->drawRect(6, 6, 145, 70, 512, 384, 2);
	}else{
		wallHelper->drawRect(6, 6, 145, 70, 512, 454, 2);
	}
	if(toDialog || atDialog){
		if(direction == 1){
			dialog_pos = ((ofGetElapsedTimeMillis()-dialogStart)/60);
		}else{
			dialog_pos = 7-((ofGetElapsedTimeMillis()-dialogStart)/60);
		}
		dialog_pos = min(7, max(1, dialog_pos));
		if(dialog_pos == 7 && direction == 1)
		{
			toDialog = false;
			atDialog = true;
		}else if(dialog_pos == 1 && direction == 0){
			toDialog = false;
			atDialog = false;
		}
		[self renderDialogFrame:dialog_pos];
	}
	[self renderHighlight];
	[super render];
}
-(void)renderDialogFrame:(int)frameNumber
{
	int offset_x = 30;
	int offset_y = 100;
	GLButton *currentButton = [phraseButtons objectAtIndex:jar_to_save];
	offset_x = offset_x-(offset_x-currentButton.frame.origin.x)*((float)7-frameNumber)/7.0;
	offset_y = offset_y-(offset_y-currentButton.frame.origin.y)*((float)7-frameNumber)/7.0;
	switch(frameNumber)
	{
			// position, size, input size, offset, texture
		case 1:
			wallHelper->drawRect(offset_x, offset_y, 86, 86, 43, 43, 512, 525, 2);
			break;
		case 2:
			wallHelper->drawRect(offset_x, offset_y, 124, 100, 62, 50, 512, 568, 2);
			break;
		case 3:
			wallHelper->drawRect(offset_x, offset_y, 170, 142, 85, 71, 512, 618, 2);
			break;
		case 4:
			wallHelper->drawRect(offset_x, offset_y, 228, 222, 114, 111, 512, 689, 2);
			break;
		case 5:
			wallHelper->drawRect(offset_x, offset_y, 228, 248, 114, 124, 512, 800, 2);
			break;
		case 6:
			wallHelper->drawRect(offset_x, offset_y, 262, 258, 131, 129, 597, 525, 2);
			break;
		case 7:
			wallHelper->drawRect(offset_x, offset_y, 270, 265, 629, 656, 2);
			break;
	}
}
-(void)renderHighlight
{
	int offset_x = -35;
	int offset_y = -30;
	if(jar_to_load<2){
		offset_x = -40;
		offset_y = -20;
	}
	if(jar_to_load<5){
		offset_x = -40;
	}
	if(jar_to_load==3){
		offset_x = -35;
	}
	if(jar_to_load==5){
		offset_x = -50;
	}
	if(jar_to_load==6){
		offset_x = -30;
	}
	if(jar_to_load==7){
		offset_x = -40;
	}
	int currentTime = ofGetElapsedTimeMillis() - fadeStart;
	GLButton *loaded_jar = [phraseButtons objectAtIndex:jar_to_load];
	if(tweening){
		if(currentTime > 700){
			tweening = false;
			wallHelper->setAlpha(0.0);
		}else if(currentTime > 350){
			wallHelper->setAlpha(((float)(700-currentTime))/350.0);
		}else{
			wallHelper->setAlpha(((float)currentTime)/350.0);
		}
		wallHelper->drawRect(loaded_jar.frame.origin.x+offset_x, loaded_jar.frame.origin.y+offset_y, 144, 168, 0, 794, 2);
	}
	wallHelper->setAlpha(1.0);
}
@end
