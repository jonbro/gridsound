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
		void drawRect(int x, int y, int width, int height, int offset_x, int offset_y, int texture);
		void drawRect(int x, int y, int width, int height, int inputWidth, int inputHeight, int offset_x, int offset_y, int texture);
		void zoomFromBook(int startBook);
		void setBookOffsets(int book);
		void drawNonZoom();
		void toInfo();
		void setColor(int color);
		void fromInfo();
		void toHelp(int help);
		void fromHelp();
		bool zooming, zoomingSecondary, infoTransition, info, firstZoom, help, helpTransition;
	protected:
		ofImage atlas, zoomerAtlas, helpAtlas, bankAtlas;
		ofTexture atlasTex, zoomerAtlasTex, helpAtlasTex, bankAtlasTex;
		ofxMSAShape3D *myShape;
		int currentFrame, direction, startMove, startFrame, zoomDirection, startZoom, offset_x_target, offset_y_target;
		int zoomSpeed, zoomSpeedSecondary, infoDirection, infoPosition, infoStart;
		int helpDirection, helpPosition, helpStart, helpScreen;
		int currentColor;
		float cloud1XPosition, cloud2XPosition, cloud3XPosition;
		float balloonX, balloonY, scaleTarget;
		bool hasColor;
	};

