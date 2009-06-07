/*
 *  gridControllerHelper.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 5/19/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#import "ofxMSAShape3D.h"
#import "ofMain.h"

class wallFolderHelper
{		
	public:
		wallFolderHelper();
		~wallFolderHelper();
		drawWall();
		openWall();
		closeWall();
	protected:
		ofImage atlas;
		ofxMSAShape3D *myShape;
		ofTexture atlasTex;
		int currentFrame, direction, startMove;
	};

