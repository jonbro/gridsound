/*
 *  gridControllerHelper.cpp
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 5/19/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "gridControllerHelper.h"

wallFolderHelper::wallFolderHelper()
{	
	atlas.loadImage("texture_atlas_books.apng");
	atlas.setImageType(OF_IMAGE_COLOR_ALPHA);
	atlasTex = atlas.getTextureReference();
	myShape = new ofxMSAShape3D();
}

//--------------------------------------------------------------
wallFolderHelper::~wallFolderHelper()
{
	
}
