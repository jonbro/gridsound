/*
 *  ofxiPhonePickerView.mm
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/29/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "ofxiPhonePickerView.h"
#import "iPhoneGlobals.h"

//--------------------------------------------------------------
ofxiPhonePickerView::ofxiPhonePickerView(int _x, int _y, int _w, int _h)
{
	picker = [[ofxiPhonePickerViewDelegate alloc] 
				init:	_x 
				y:		_y 
				width:	_w 
				height:	_h];
	x=_x;
	y=_y;
	w = _w;
	h = _h;
}

//--------------------------------------------------------------
ofxiPhonePickerView::~ofxiPhonePickerView()
{
	[picker release];
}

void ofxiPhonePickerView::setVisible(bool visible)
{
	if(visible)
	{
		[picker showPicker];
	}
	else
	{
		[picker hidePicker];
	}
	
}



@implementation ofxiPhonePickerViewDelegate

- (id) init:(int)x y:(int)y width:(int)w height:(int)h
{
	if(self = [super init])
	{			
		myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(x, y, w, h)];
		[myPickerView setDelegate:self];
		myPickerView.showsSelectionIndicator = YES;	// note this is default to NO
		myPickerView.hidden = NO;

	}
	return self;
}
- (void) showPicker
{
	[iPhoneGlobals.window addSubview:myPickerView];

}
- (void) hidePicker
{
	[myPickerView removeFromSuperview];

}

@end