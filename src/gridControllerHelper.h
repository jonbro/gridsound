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
		void drawForeground();
		void drawVolume(float volLevel);
		void drawButton(int x, int y, int frame);
	
	protected:
		ofImage atlas;
		ofxMSAShape3D *myShape;
		ofTexture atlasTex;
	};

