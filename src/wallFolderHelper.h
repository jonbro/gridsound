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
		void drawWall();
		void openWall();
		void closeWall();
		void setBalloon(float x, float y);
		void drawScalerWall(int offset_x, int offset_y, float scale);
	
	protected:
		ofImage atlas, zoomerAtlas;
		ofxMSAShape3D *myShape;
		ofTexture atlasTex, zoomerAtlasTex;
		int currentFrame, direction, startMove, startFrame;
		float balloonX, balloonY;
	};

