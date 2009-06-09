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
	
	myShape = new ofxMSAShape3D();
}

//--------------------------------------------------------------
gridControllerHelper::~gridControllerHelper()
{
	
}

void gridControllerHelper::drawBackground()
{
	this->drawRect(0, 0, 320, 480, 0, 0);
	// draw control backgrounds
	this->drawRect(0, 312, 320, 168, 0, 480);
	
}
void gridControllerHelper::drawForeground()
{
	this->drawRect(0, 312, 320, 168, 0, 480);	
}
void gridControllerHelper::drawVolume(float volLevel)
{
	this->drawRect((int)(volLevel*80), 369, 89, 44, 51, 647);
}
void gridControllerHelper::drawButton(int x, int y)
{
	this->drawRect(x*40, y*40, 40, 40, 0, 691);
}
void gridControllerHelper::drawRect(int x, int y, int width, int height, int offset_x, int offset_y){

	int atlasWidth = 512;
	int atlasHeight = 1024;
	
	float t_1 = (float)offset_x/(float)atlasWidth;
	float t_2 = (float)(offset_x+width)/(float)atlasWidth;

	float u_1 = (float)(atlasHeight-offset_y)/(float)atlasHeight;
	float u_2 = (float)(atlasHeight-(offset_y+height))/(float)atlasHeight;

	atlasTex.bind();
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
	atlasTex.unbind();
	
}