/*
 *  ofIphoneKeyboard.h
 *  iPhone UIKeyboard Example
 *
 *  Created by Zach Gage on 3/1/09.
 *  Copyright 2009 stfj. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "ofMain.h"

@interface ofxiPhoneKeyboardDelegate : NSObject <UITextFieldDelegate>
{
	UITextField*			_textField;
	bool					open;
	char *					_ctext;
}
- (id) init: (int)x y:(int)y width:(int)w height:(int)h;
- (void) showText;
- (void) hideText;
- (char *) getText;
- (void) setText: (NSString *)text;
- (void) setFontSize: (int)size;
- (void) setFontColorRed: (int)r green: (int)g blue:(int)b alpha:(int)a;
- (void) setBgColorRed: (int)r green: (int)g blue:(int)b alpha:(int)a;
- (bool) isKeyboardShowing;
- (void) setFrame: (CGRect) rect;
- (void) setPlaceholder: (NSString *)text;
- (void) openKeyboard;


@end

class ofxiPhoneKeyboard 
	{
		
	public:
		
		ofxiPhoneKeyboard(int _x, int _y, int _w, int _h);
		~ofxiPhoneKeyboard();
		
		void setVisible(bool visible);
		
		void setPosition(int _x, int _y);
		void setSize(int _w, int _h);
		void setFontSize(int ptSize);
		void setFontColor(int r, int g, int b, int a);
		void setBgColor(int r, int g, int b, int a);
		void setText(string _text);
		void setPlaceholder(string _text);
		void openKeyboard();
		string getText();
		bool isKeyboardShowing();
		
		
		
	protected:
		
		ofxiPhoneKeyboardDelegate *	keyboard;
		int x,y,w,h;
	};