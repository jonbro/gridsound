/*
 *  gridControllerHelper.cpp
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 5/19/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "wallFolderHelperOBJC.h"

@implementation wallFolderHelperOBJC

-(id) init
{	
	self = [super init];
	myShape = new ofxMSAShape3D();
	return self;
}
-(void)drawScalerWallOffsetX:(int)offset_x offsetY:(int)offset_y scale:(int)scale
{
	// texture calculaaation!
	
	int atlasWidth = 1024;
	int atlasHeight = 1024;
	
	float t_1 = (float)offset_x/(float)atlasWidth;
	float t_2 = (float)(offset_x+320*scale)/(float)atlasWidth;
	
	float u_1 = (float)(atlasHeight-offset_y)/(float)atlasHeight;
	float u_2 = (float)(atlasHeight-(offset_y+480*scale))/(float)atlasHeight;	
	
	[texturePool bindTexture:@"zoomer_atlas"];
	myShape->begin(GL_TRIANGLE_STRIP);
	myShape->setTexCoord(t_1, u_1);
	myShape->addVertex(0, 0);
	
	myShape->setTexCoord(t_2, u_1);
	myShape->addVertex(320, 0);
	
	myShape->setTexCoord(t_1, u_2);
	myShape->addVertex(0, 480);
	
	myShape->setTexCoord(t_2, u_2);
	myShape->addVertex(320, 480);
	myShape->end();				
	[texturePool unbindTexture];
}
-(void)drawWall
{
	if(!zooming && !zoomingSecondary){
		glPushMatrix();
		if(info || infoTransition){
			if(infoDirection ==0){
				infoPosition += ((ofGetElapsedTimeMillis()-infoStart)/30);
				if(infoPosition>=320){
					infoPosition = 320;
					info = true;
					infoTransition = false;
				}
			}else{
				infoPosition -= ((ofGetElapsedTimeMillis()-infoStart)/30);
				if(infoPosition<=0){
					infoPosition = 0;
					infoTransition = false;
				}
			}
			glTranslatef(-infoPosition, 0, 0);
			this->drawRect(320, 0, 320, 480, 683, 480, 1);
		}
		this->drawNonZoom();
		if(currentFrame == 0){
			[self drawScalerWallOffsetX:0 offsetY:0 scale:2.1333333];
		}
		this->drawRect(0-currentFrame*5, 216, 53, 84, 713, 393, 1);
		glPopMatrix();
	}
	if(zooming){
		if(zoomDirection == 0){
			this->drawScalerWall(this->tweenLinearCurrentTime(ofGetElapsedTimeMillis()-startZoom, 0, offset_x_target, zoomSpeed), this->tweenLinearCurrentTime(ofGetElapsedTimeMillis()-startZoom, 0, offset_y_target, zoomSpeed), this->tweenLinearCurrentTime(ofGetElapsedTimeMillis()-startZoom, 2.13333333, scaleTarget, zoomSpeed));
		}else{
			glEnable(GL_DEPTH_TEST);
			glPushMatrix();
			glRotatef(this->tweenLinearCurrentTime(ofGetElapsedTimeMillis()-startZoom, -99, 99, zoomSpeed), 0, 1, 0);
			this->drawScalerWall(offset_x_target, offset_y_target, 2.13333+scaleTarget);
			glTranslatef(320, 0, 0);
			glRotatef(90, 0, 1, 0);
			this->drawScalerWall(686, 0, 1);
			glPopMatrix();
			glDisable(GL_DEPTH_TEST);			
		}
		if(ofGetElapsedTimeMillis()-startZoom>zoomSpeed){
			zooming = false;
			zoomingSecondary = true;
			startZoom = ofGetElapsedTimeMillis();
		}
	}
	if(zoomingSecondary){
		if(zoomDirection == 0){
			glEnable(GL_DEPTH_TEST);
			glPushMatrix();
			glRotatef(this->tweenLinearCurrentTime(ofGetElapsedTimeMillis()-startZoom, 0, -99, zoomSpeedSecondary), 0, 1, 0);
			this->drawScalerWall(offset_x_target, offset_y_target, 2.13333+scaleTarget);
			glTranslatef(320, 0, 0);
			glRotatef(90, 0, 1, 0);
			this->drawScalerWall(686, 0, 1);
			glPopMatrix();
			glDisable(GL_DEPTH_TEST);
		}else{
			this->drawScalerWall(this->tweenLinearCurrentTime(ofGetElapsedTimeMillis()-startZoom, offset_x_target, -offset_x_target, zoomSpeedSecondary), this->tweenLinearCurrentTime(ofGetElapsedTimeMillis()-startZoom, offset_y_target, -offset_y_target, zoomSpeedSecondary), this->tweenLinearCurrentTime(ofGetElapsedTimeMillis()-startZoom, .265333333333333, -scaleTarget, zoomSpeedSecondary));
		}
		if(ofGetElapsedTimeMillis()-startZoom>zoomSpeedSecondary){
			zoomingSecondary = false;
		}
	}	
}

@end