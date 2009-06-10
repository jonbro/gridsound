/*
 *  gridControllerHelper.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 5/19/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#import "ofxMSAShape3D.h"

class gridControllerHelper
{		
	public:
		gridControllerHelper();
		~gridControllerHelper();
		void drawBackground();
		void drawRect(int x, int y, int width, int height, int offset_x, int offset_y);
		void drawRectTexture(int x, int y, int width, int height, int offset_x, int offset_y, int texture);
		void drawForeground();
		void drawVolume(float volLevel);
		void drawButton(int x, int y, int frame);
		void showBelt();
		void setCurrentFrame(int frame);
		float tweenLinearCurrentTime(float t, float b, float c, float d);
		void rollOutBelt();
		void rollInBelt();
	protected:
		ofImage atlas, beltAtlas;
		int currentFrame, startMove;
		int direction;
		ofxMSAShape3D *myShape;
		ofTexture atlasTex, beltAtlasTex;
	};

