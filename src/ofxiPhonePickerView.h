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
}
- (id) init: (int)x y:(int)y width:(int)w height:(int)h;
- (void) showPicker;
- (void) hidePicker;

@end

class ofxiPhonePickerView 
{		
	public:
		ofxiPhonePickerView(int _x, int _y, int _w, int _h);
		~ofxiPhonePickerView();
		void setVisible(bool visible);
	protected:		
		ofxiPhonePickerViewDelegate *picker;
		int x,y,w,h;
};