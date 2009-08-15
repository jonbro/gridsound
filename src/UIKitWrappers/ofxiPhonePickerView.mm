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
ofxiPhonePickerView::ofxiPhonePickerView(int _x, int _y, int _w, int _h, NSArray* _array)
{
	pickerArray = [_array retain];
	picker = [[ofxiPhonePickerViewDelegate alloc] 
				init:	_x 
				y:		_y 
				width:	_w 
				height:	_h
				pickerArray: pickerArray];
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
void ofxiPhonePickerView::setNewArray(NSArray* _array){
	[picker setArray:_array];
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
void ofxiPhonePickerView::setPosition(int _x, int _y)
{
	x=_x;
	y=_y;
	[picker setFrame: CGRectMake(x,y,w,h)];
}
int ofxiPhonePickerView::getRow()
{
	return [picker getRow];
}
void ofxiPhonePickerView::setRow(int _row)
{
	[picker setRow:_row];
}
@implementation ofxiPhonePickerViewDelegate

- (id) init:(int)x y:(int)y width:(int)w height:(int)h pickerArray:(NSArray*)_array
{
	if(self = [super init])
	{
		pickerViewArray = [_array retain];
		myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(x, y, w, h)];
		[myPickerView setDelegate:self];
		myPickerView.showsSelectionIndicator = YES;	// note this is default to NO
		myPickerView.hidden = NO;
	}
	return self;
}
- (void) setArray:(NSArray*)_newArray
{
	NSArray* oldArray = pickerViewArray;
	pickerViewArray = [_newArray retain];
	[myPickerView reloadAllComponents];
	[oldArray release];
}
- (void) showPicker
{
	[iPhoneGlobals.window addSubview:myPickerView];
}
- (void) hidePicker
{
	[myPickerView removeFromSuperview];
}
- (void) setFrame: (CGRect) rect
{
	[myPickerView setFrame:rect];
}
- (int)getRow
{
	return [myPickerView selectedRowInComponent:0];
}
- (void)setRow:(int)_row
{
	NSLog(@"setting row: %i", _row);
	[myPickerView selectRow:_row inComponent:0 animated:NO];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr;
	returnStr = [pickerViewArray objectAtIndex:row];
	return returnStr;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [pickerViewArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

@end