/*
 *  gridControllerHelper.cpp
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 5/19/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "gridControllerHelper.h"

gridControllerHelper::gridControllerHelper()
{	
	atlas.loadImage("texture_atlas_interior.png");
	atlas.setImageType(OF_IMAGE_COLOR_ALPHA);
	atlasTex = atlas.getTextureReference();
	
	beltAtlas.loadImage("texture_atlas_belt.png");
	beltAtlas.setImageType(OF_IMAGE_COLOR_ALPHA);
	beltAtlasTex = beltAtlas.getTextureReference();
	sampleFont.loadFont("DejaVuSerifCondensed-Bold.ttf", 11);
	myShape = new ofxMSAShape3D();
	currentFrame = 0;
	direction = 0;
}

//--------------------------------------------------------------
gridControllerHelper::~gridControllerHelper()
{
	
}
void gridControllerHelper::setCurrentFrame(int frame)
{
	currentFrame = frame;
}
void gridControllerHelper::showBelt(NSArray* samples){
	if(currentFrame>-1){
	if(direction == 0){
		currentFrame -= ((ofGetElapsedTimeMillis()-startMove)/200);
	}else{
		currentFrame += ((ofGetElapsedTimeMillis()-startMove)/200);
	}
	currentFrame = min(13, max(-1, currentFrame));
	
	switch (currentFrame) {
		case 0 :
			this->drawRectTexture(46, 0, 108, 41, 0, 0, 1);
		case 1 : 
			this->drawRectTexture(46, 0, 108, 74, 0, 42, 1);
			break;
		case 2 : 
			this->drawRectTexture(46, 0, 108, 110, 0, 116, 1);
			break;
		case 3 : 
			this->drawRectTexture(45, 0, 109, 148, 0, 226, 1);
			break;
		case 4 : 
			this->drawRectTexture(46, 0, 108, 190, 0, 374, 1);
			break;
		case 5 : 
			this->drawRectTexture(46, 0, 108, 232, 0, 564, 1);
			break;
		case 6 : 
			this->drawRectTexture(46, 0, 110, 276, 109, 0, 1);
			break;
		case 7 : 
			this->drawRectTexture(46, 0, 110, 320, 109, 276, 1);
			break;
		case 8 : 
			this->drawRectTexture(46, 0, 110, 428, 109, 596, 1);
			break;
		case 9 : 
			this->drawRectTexture(46, 0, 102, 404, 220, 0, 1);
			break;
		case 10 : 
			this->drawRectTexture(46, 0, 102, 454, 220, 404, 1);
			break;
		case 11 : 
			this->drawRectTexture(46, 0, 93, 473, 323, 0, 1);
			break;
		case 12 : 
			this->drawRectTexture(46, 0, 93, 480, 323, 473, 1);
			break;
		case 13 : 
			this->drawRectTexture(46, 0, 106, 475, 416, 0, 1);
			break;
		default :
			break;
	}
	if(currentFrame >= 11){
		int lineHeight = 20;
		int offset;
		for(int i=0;i<[samples count];i++){
			offset = (86 - sampleFont.stringWidth([[samples objectAtIndex:i] UTF8String]))/2;
			if(i==currentLoop){
				ofSetColor(0xc69c6d);
			}else{
				ofSetColor(0xffffff);				
			}
			sampleFont.drawString([[samples objectAtIndex:i] UTF8String], 48+offset, lineHeight);

			//draw seperator
			ofSetColor(0xffffff);
			this->drawRectTexture(53, lineHeight+12, 81, 14, 418, 478, 1);

			lineHeight += 40;
		}
	}
	}
}
void gridControllerHelper::setCurrentLoop(int loop)
{
	currentLoop = loop;
}
float gridControllerHelper::tweenLinearCurrentTime(float t, float b, float c, float d)
{
	return c*t/d + b;
}
void gridControllerHelper::rollOutBelt()
{
	startMove = ofGetElapsedTimeMillis();
	currentFrame = 0;
	direction = 1;
}
void gridControllerHelper::rollInBelt()
{
	startMove = ofGetElapsedTimeMillis();
	direction = 0;
}
void gridControllerHelper::drawBackground()
{
	this->drawRect(0, 0, 320, 480, 0, 0);
	// draw control backgrounds
	this->drawRect(0, 312, 320, 168, 0, 480);
}
void gridControllerHelper::drawForeground(NSArray* samples)
{
	this->drawRect(0, 312, 320, 168, 0, 480);	
	//draw belt
	
}
void gridControllerHelper::drawVolume(float volLevel)
{
	this->drawRect((int)(volLevel*80), 369, 89, 44, 51, 647);
}
void gridControllerHelper::drawButton(int x, int y, int frame)
{
	this->drawRect(x*37+10, y*37+10, 40, 40, 40*frame, 691);
}
void gridControllerHelper::drawRect(int x, int y, int width, int height, int offset_x, int offset_y){
	this->drawRectTexture(x, y, width, height, offset_x, offset_y, 0);
}
void gridControllerHelper::drawMute(int mute)
{
	int top = 418+7;
	int offsetTop = 731+7;
	int _height = 44;
	if(mute==0){
		this->drawRectTexture(25, top, _height, _height, 25, offsetTop, 0);
	}
	if(mute==1){
		this->drawRectTexture(91, top, _height, _height, 91, offsetTop, 0);
	}
	if(mute==2){
		this->drawRectTexture(157, top, _height, _height, 157, offsetTop, 0);
	}
}
void gridControllerHelper::drawDirection(bool playBackDirection){
	glPushMatrix();
	glTranslatef(161, 317+24, 0);
	if(!playBackDirection){
		glRotatef(180, 0, 0, 1);
	}
	glTranslatef(-25, -24, 0);
	this->drawRectTexture(0, 0, 64, 47, 137, 805, 0);
	glPopMatrix();
}
void gridControllerHelper::drawRectTexture(int x, int y, int width, int height, int offset_x, int offset_y, int texture){

	int atlasWidth = 512;
	int atlasHeight = 1024;
	
	float t_1 = (float)offset_x/(float)atlasWidth;
	float t_2 = (float)(offset_x+width)/(float)atlasWidth;

	float u_1 = (float)(atlasHeight-offset_y)/(float)atlasHeight;
	float u_2 = (float)(atlasHeight-(offset_y+height))/(float)atlasHeight;
	
	if(texture == 0){
		atlasTex.bind();
	}else{
		beltAtlasTex.bind();
	}
	glPushMatrix();
	myShape->begin(GL_TRIANGLE_STRIP);
	myShape->setTexCoord(t_1, u_1);
	myShape->addVertex(x, y);
	
	myShape->setTexCoord(t_2, u_1);
	myShape->addVertex(x+width, y);
	
	// going to move these up based on mutes eventually
	myShape->setTexCoord(t_1, u_2);
	myShape->addVertex(x, y+height);
	
	myShape->setTexCoord(t_2, u_2);
	myShape->addVertex(x+width, y+height);
	
	myShape->end();
	glPopMatrix();
	if(texture ==0){
		atlasTex.unbind();
	}else{
		beltAtlasTex.unbind();
	}
}