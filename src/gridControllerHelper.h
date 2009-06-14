/*
 *  gridControllerHelper.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 5/19/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#import "ofxMSAShape3D.h"
#import "ofTrueTypeFont.h"

class gridControllerHelper
{		
	public:
		gridControllerHelper();
		~gridControllerHelper();
		void drawBackground();
		void drawRect(int x, int y, int width, int height, int offset_x, int offset_y);
		void drawRectTexture(int x, int y, int width, int height, int offset_x, int offset_y, int texture);
		void drawForeground(NSArray* samples);
		void drawVolume(float volLevel);
		void drawButton(int x, int y, int frame);
		void showBelt(NSArray* samples);
		void setCurrentFrame(int frame);
		float tweenLinearCurrentTime(float t, float b, float c, float d);
		void rollOutBelt();
		void rollInBelt();
		void setCurrentLoop(int loop);
		void drawMute(int mute);
		void drawDirection(bool playBackDirection);
	
	protected:
		ofImage atlas, beltAtlas;
		ofTrueTypeFont sampleFont;
		int currentFrame, startMove, currentLoop;
		int direction;
		ofxMSAShape3D *myShape;
		ofTexture atlasTex, beltAtlasTex;
	};

