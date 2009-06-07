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

	myShape = new ofxMSAShape3D();
	currentFrame = 0;
	startMove = ofGetElapsedTimeMillis();
}

//--------------------------------------------------------------
wallFolderHelper::~wallFolderHelper()
{
	
}

void wallFolderHelper::drawWall()
{
	atlasTex.bind();
	glPushMatrix();
	float sze = 1024.0;
	currentFrame = ((ofGetElapsedTimeMillis()-startMove)/100)%2;
	switch (currentFrame) {
		case 1 : 
			{
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
			}
			break;
		default : 
			{
				float topX = 639.0/sze;
				float topY = 649.0/sze;
				float bottomX = 958.0/sze;
				float bottomY = 213.0/sze;
				myShape->begin(GL_TRIANGLE_STRIP);
				myShape->setTexCoord(topX, topY);
				myShape->addVertex(0, 0);
				
				myShape->setTexCoord(bottomX, topY);
				myShape->addVertex(320, 0);
				
				// going to move these up based on mutes eventually
				myShape->setTexCoord(topX, bottomY);
				myShape->addVertex(0, 437);
				
				myShape->setTexCoord(bottomX, bottomY);
				myShape->addVertex(320, 437);
				myShape->end();
				topX = 0/sze;
				topY = 585.0/sze;
				bottomX = 320.0/sze;
				bottomY = 545.0/sze;
				myShape->begin(GL_TRIANGLE_STRIP);
				myShape->setTexCoord(topX, topY);
				myShape->addVertex(0, 437);
				
				myShape->setTexCoord(bottomX, topY);
				myShape->addVertex(320, 437);
				
				myShape->setTexCoord(topX, bottomY);
				myShape->addVertex(0, 480);
				
				myShape->setTexCoord(bottomX, bottomY);
				myShape->addVertex(320, 480);
				
				myShape->end();
				
				//
			}
	}
	atlasTex.unbind();
	glPopMatrix();				
}
void wallFolderHelper::openWall()
{
	
}
void wallFolderHelper::closeWall()
{
	
}
