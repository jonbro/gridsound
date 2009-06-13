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
		float tweenLinearCurrentTime(float t, float b, float c, float d);
		float tweenQuadraticCurrentTime(float t, float b, float c, float d);
		void zoomToBook(int book);
		void drawMute(int mute);
		void drawRect(int x, int y, int width, int height, int offset_x, int offset_y);
		void zoomFromBook();
		void drawNonZoom();
		bool zooming, zoomingSecondary;
	protected:
		ofImage atlas, zoomerAtlas;
		ofxMSAShape3D *myShape;
		ofTexture atlasTex, zoomerAtlasTex;
		int currentFrame, direction, startMove, startFrame, zoomDirection, startZoom, offset_x_target, offset_y_target, zoomSpeed, zoomSpeedSecondary;
		float balloonX, balloonY, scaleTarget;
	};

