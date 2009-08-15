/*
 *  ofxiPhonePickerView.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/29/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "ofMain.h"

@interface ofxiPhonePickerViewDelegate : NSObject <UIPickerViewDelegate>
{
	UIPickerView			*myPickerView;
	NSArray					*pickerViewArray;
}
- (id) init: (int)x y:(int)y width:(int)w height:(int)h pickerArray:(NSArray*)_array;
- (void) showPicker;
- (void) hidePicker;
- (int)getRow;
- (void)setRow:(int)_row;
- (void) setFrame: (CGRect) rect;
- (void) setArray:(NSArray*)_newArray;

@end

class ofxiPhonePickerView 
{		
	public:
		ofxiPhonePickerView(int _x, int _y, int _w, int _h, NSArray* _array);
		~ofxiPhonePickerView();
		void setNewArray(NSArray* _array);
		void setVisible(bool visible);
		int getRow();
		void setRow(int _row);
		void setPosition(int _x, int _y);
	protected:		
		ofxiPhonePickerViewDelegate *picker;
		int x,y,w,h;
		NSArray* pickerArray;
};