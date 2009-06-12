/*
 *  gridControllerHelper.cpp
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 5/19/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "wallFolderHelper.h"

wallFolderHelper::wallFolderHelper()
{	
	atlas.loadImage("texture_atlas_books.png");
	atlas.setImageType(OF_IMAGE_COLOR_ALPHA);
	atlasTex = atlas.getTextureReference();
	
	zoomerAtlas.loadImage("zoomer_atlas.png");
	zoomerAtlas.setImageType(OF_IMAGE_COLOR_ALPHA);
	zoomerAtlasTex = zoomerAtlas.getTextureReference();

	myShape = new ofxMSAShape3D();
	currentFrame = 0;
	startFrame = 0;
	direction = 0;
	startMove = ofGetElapsedTimeMillis();
	balloonX = balloonY = 160;
	zooming = false;
	zoomingSecondary = false;
}

//--------------------------------------------------------------
wallFolderHelper::~wallFolderHelper()
{
	
}
void wallFolderHelper::setBalloon(float x, float y){
	balloonX = (int)x;
	balloonY = (int)y;
}
void wallFolderHelper::drawNonZoom()
{
	atlasTex.bind();
	glPushMatrix();
	float sze = 1024.0;
	if(direction ==0){
		currentFrame -= ((ofGetElapsedTimeMillis()-startMove)/120);
	}else{
		currentFrame += ((ofGetElapsedTimeMillis()-startMove)/120);
	}
	currentFrame = min(8, max(0, currentFrame));
	//draw the bottom layer
	float topX = 0/sze;
	float topY = 1024.0/sze;
	float bottomX = 320.0/sze;
	float bottomY = 544.0/sze;
	
	myShape->begin(GL_TRIANGLE_STRIP);
	myShape->setTexCoord(topX, topY);
	myShape->addVertex(0, 0);
	
	myShape->setTexCoord(bottomX, topY);
	myShape->addVertex(320, 0);
	
	// going to move these up based on mutes eventually
	myShape->setTexCoord(topX, bottomY);
	myShape->addVertex(0, 480);
	
	myShape->setTexCoord(bottomX, bottomY);
	myShape->addVertex(320, 480);
	myShape->end();
	
	if(currentFrame > 1){
		// draw wall
		float topX = 640.0/sze;
		float topY = 210.0/sze;
		float bottomX = 958.0/sze;
		float bottomY = 0.0/sze;
		
		myShape->begin(GL_TRIANGLE_STRIP);
		myShape->setTexCoord(topX, topY);
		myShape->addVertex(0, 0);
		
		myShape->setTexCoord(bottomX, topY);
		myShape->addVertex(320, 0);
		
		myShape->setTexCoord(topX, bottomY);
		myShape->addVertex(0, 315);
		
		myShape->setTexCoord(bottomX, bottomY);
		myShape->addVertex(320, 315);
		myShape->end();
		// draw balloon
		// x = 64 y = 106
		
		topX = 960.0/sze;
		topY = 1024.0/sze;
		bottomX = 1024.0/sze;
		bottomY = 918.0/sze;
		
		myShape->begin(GL_TRIANGLE_STRIP);
		myShape->setTexCoord(topX, topY);
		myShape->addVertex(balloonX-32, balloonY-54);
		
		myShape->setTexCoord(bottomX, topY);
		myShape->addVertex(balloonX+32, balloonY-54);
		
		myShape->setTexCoord(topX, bottomY);
		myShape->addVertex(balloonX-32, balloonY+54);
		
		myShape->setTexCoord(bottomX, bottomY);
		myShape->addVertex(balloonX+32, balloonY+54);
		myShape->end();
		
		
	}
	switch (currentFrame) {
		case 1 : 
		{
		}
			break;
		case 2 :
		{
			topX = 0/sze;
			topY = 544.0/sze;
			bottomX = 320.0/sze;
			bottomY = 163.0/sze;
			
			myShape->begin(GL_TRIANGLE_STRIP);
			myShape->setTexCoord(topX, topY);
			myShape->addVertex(0, 0);
			
			myShape->setTexCoord(bottomX, topY);
			myShape->addVertex(320, 0);
			
			myShape->setTexCoord(topX, bottomY);
			myShape->addVertex(0, 382);
			
			myShape->setTexCoord(bottomX, bottomY);
			myShape->addVertex(320, 382);
			myShape->end();				
		}
			break;
		case 3 :
		{
			topX = 320.0/sze;
			topY = 1024.0/sze;
			bottomX = 640.0/sze;
			bottomY = 643.0/sze;
			
			myShape->begin(GL_TRIANGLE_STRIP);
			myShape->setTexCoord(topX, topY);
			myShape->addVertex(0, 0);
			
			myShape->setTexCoord(bottomX, topY);
			myShape->addVertex(320, 0);
			
			myShape->setTexCoord(topX, bottomY);
			myShape->addVertex(0, 382);
			
			myShape->setTexCoord(bottomX, bottomY);
			myShape->addVertex(320, 382);
			myShape->end();				
		}
			break;
		case 4 :
		{
			// 340
			topX = 320.0/sze;
			topY = 643.0/sze;
			bottomX = 640.0/sze;
			bottomY = 303.0/sze;
			
			myShape->begin(GL_TRIANGLE_STRIP);
			myShape->setTexCoord(topX, topY);
			myShape->addVertex(0, 41);
			
			myShape->setTexCoord(bottomX, topY);
			myShape->addVertex(320, 41);
			
			myShape->setTexCoord(topX, bottomY);
			myShape->addVertex(0, 382);
			
			myShape->setTexCoord(bottomX, bottomY);
			myShape->addVertex(320, 382);
			myShape->end();				
		}
			break;
		case 5 :
		{
			// 257
			topX = 320.0/sze;
			topY = 303.0/sze;
			bottomX = 640.0/sze;
			bottomY = 48.0/sze;
			
			myShape->begin(GL_TRIANGLE_STRIP);
			myShape->setTexCoord(topX, topY);
			myShape->addVertex(0, 83);
			
			myShape->setTexCoord(bottomX, topY);
			myShape->addVertex(320, 83);
			
			myShape->setTexCoord(topX, bottomY);
			myShape->addVertex(0, 382);
			
			myShape->setTexCoord(bottomX, bottomY);
			myShape->addVertex(320, 382);
			myShape->end();				
		}
			break;
		case 6 :
		{
			// 176
			topX = 640.0/sze;
			topY = 1024.0/sze;
			bottomX = 960.0/sze;
			bottomY = 848.0/sze;
			
			myShape->begin(GL_TRIANGLE_STRIP);
			myShape->setTexCoord(topX, topY);
			myShape->addVertex(0, 206);
			
			myShape->setTexCoord(bottomX, topY);
			myShape->addVertex(320, 206);
			
			myShape->setTexCoord(topX, bottomY);
			myShape->addVertex(0, 382);
			
			myShape->setTexCoord(bottomX, bottomY);
			myShape->addVertex(320, 382);
			myShape->end();				
		}
			break;
		case 7 :
		{
			// 115
			topX = 640.0/sze;
			topY = 849.0/sze;
			bottomX = 960.0/sze;
			bottomY = 734.0/sze;
			
			myShape->begin(GL_TRIANGLE_STRIP);
			myShape->setTexCoord(topX, topY);
			myShape->addVertex(0, 267);
			
			myShape->setTexCoord(bottomX, topY);
			myShape->addVertex(320, 267);
			
			myShape->setTexCoord(topX, bottomY);
			myShape->addVertex(0, 382);
			
			myShape->setTexCoord(bottomX, bottomY);
			myShape->addVertex(320, 382);
			myShape->end();				
		}
			break;
		case 8 :
		{
			// 82
			topX = 640.0/sze;
			topY = 731.0/sze;
			bottomX = 959.0/sze;
			bottomY = 652.0/sze;
			
			myShape->begin(GL_TRIANGLE_STRIP);
			myShape->setTexCoord(topX, topY);
			myShape->addVertex(0, 300);
			
			myShape->setTexCoord(bottomX, topY);
			myShape->addVertex(320, 300);
			
			myShape->setTexCoord(topX, bottomY);
			myShape->addVertex(0, 382);
			
			myShape->setTexCoord(bottomX, bottomY);
			myShape->addVertex(320, 382);
			myShape->end();				
		}
			break;
		default : 
		{
			topX = 639.0/sze;
			topY = 649.0/sze;
			bottomX = 958.0/sze;
			bottomY = 213.0/sze;
			myShape->begin(GL_TRIANGLE_STRIP);
			myShape->setTexCoord(topX, topY);
			myShape->addVertex(0, 0);
			
			myShape->setTexCoord(bottomX, topY);
			myShape->addVertex(320, 0);
			
			myShape->setTexCoord(topX, bottomY);
			myShape->addVertex(0, 437);
			
			myShape->setTexCoord(bottomX, bottomY);
			myShape->addVertex(320, 437);
			myShape->end();
			
			//
		}
	}
	atlasTex.unbind();
	glPopMatrix();	
}
void wallFolderHelper::drawWall()
{
	if(!zooming && !zoomingSecondary){
		this->drawNonZoom();
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
void wallFolderHelper::openWall()
{
	direction = 1;
	startMove = ofGetElapsedTimeMillis();
}
void wallFolderHelper::closeWall()
{
	direction = 0;
	startMove = ofGetElapsedTimeMillis();	
}
void wallFolderHelper::zoomToBook(int book){
	zoomDirection = 0;
	zooming = true;
	startZoom = ofGetElapsedTimeMillis();
	scaleTarget = -1.868;
	zoomSpeedSecondary = 500;
	zoomSpeed = 500;
	switch (book) {
		case 0:
			offset_x_target = 86; 
			offset_y_target = 216;			
			break;
		case 1:
			offset_x_target = 291; 
			offset_y_target = 216;			
			break;
		case 2:
			offset_x_target = 506; 
			offset_y_target = 216;			
			break;
		case 3:
			offset_x_target = 117; 
			offset_y_target = 480;			
			break;
		case 4:
			offset_x_target = 299; 
			offset_y_target = 480;			
			break;
		case 5:
			offset_x_target = 479; 
			offset_y_target = 480;			
			break;
		default:
			break;
	}
}
void wallFolderHelper::zoomFromBook()
{
	zoomDirection = 1;
	zooming = true;
	zoomSpeedSecondary = 500;
	zoomSpeed = 500;
	startZoom = ofGetElapsedTimeMillis();
}
float wallFolderHelper::tweenLinearCurrentTime(float t, float b, float c, float d)
{
	return c*t/d + b;
}

float wallFolderHelper::tweenQuadraticCurrentTime(float t, float b, float c, float d)
{
	t /= d/2.0;
	if (t < 1) return c/2.0*t*t + b;
	return -c/2.0 * ((--t)*(t-2.0) - 1.0) + b;
}

void wallFolderHelper::drawScalerWall(int offset_x, int offset_y, float scale){
	// texture calculaaation!

	int atlasWidth = 1024;
	int atlasHeight = 1024;
	
	float t_1 = (float)offset_x/(float)atlasWidth;
	float t_2 = (float)(offset_x+320*scale)/(float)atlasWidth;
	
	float u_1 = (float)(atlasHeight-offset_y)/(float)atlasHeight;
	float u_2 = (float)(atlasHeight-(offset_y+480*scale))/(float)atlasHeight;	
	
	
	zoomerAtlasTex.bind();
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
	zoomerAtlasTex.unbind();
}