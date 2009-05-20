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
	buttonsOff.loadImage("allBtnsOffW.apng");
	buttonsOff.setImageType(OF_IMAGE_COLOR_ALPHA);
	buttonsOffTex = buttonsOff.getTextureReference();
	
	buttonsOn.loadImage("allBtnsOnW.apng");
	buttonsOn.setImageType(OF_IMAGE_COLOR_ALPHA);
	buttonsOnTex = buttonsOn.getTextureReference();
	myShape = new ofxMSAShape3D();
}

//--------------------------------------------------------------
gridControllerHelper::~gridControllerHelper()
{
	
}
void gridControllerHelper::drawButton(int buttonCounter, float x, float y, float textureOffsetX, float textureOffsetY)
{
	if(buttonCounter == 0){
		curTex = buttonsOffTex;
	}else{
		curTex = buttonsOnTex;
	}
	glPushMatrix();
	glTranslatef(x,y,0.0f);
	float tex_t = curTex.texData.tex_t*textureOffsetX;
	float tex_u = curTex.texData.tex_u*textureOffsetY;
	float tex_offset = curTex.texData.tex_u/8.0;
	curTex.bind();
	myShape->begin(GL_TRIANGLE_STRIP);
	myShape->setTexCoord(tex_t, tex_u);
	myShape->addVertex(0, 0);
	
	myShape->setTexCoord(tex_t+tex_offset, tex_u);
	myShape->addVertex(320/8, 0);
	
	myShape->setTexCoord(tex_t, tex_u+tex_offset);
	myShape->addVertex(0, 320/8);
	
	myShape->setTexCoord(tex_t+tex_offset, tex_u+tex_offset);
	myShape->addVertex(320/8, 320/8);
	
	myShape->enableColor(false);
	myShape->enableNormal(false);
	myShape->enableTexCoord(true);
	myShape->end();
	curTex.unbind();
	glPopMatrix();
}
