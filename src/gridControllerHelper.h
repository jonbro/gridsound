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
		void drawButton(int buttonCounter, float x, float y, float textureOffsetX, float textureOffsetY);
	protected:		
		ofImage buttonsOn, buttonsOff;
		ofxMSAShape3D *myShape;
		ofTexture buttonsOnTex, buttonsOffTex, curTex;
	};

