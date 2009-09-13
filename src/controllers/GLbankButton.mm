//
//  GLbankButton.mm
//  mujik
//
//  Created by jonbroFERrealz on 9/13/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "GLbankButton.h"

@implementation GLbankButton
@synthesize color;
-(void)render
{
	glPushMatrix();
	static GLfloat m[16];
	CGAffineToGL(&currentTranslation, m);
	glMultMatrixf(m);
	
	wallHelper->setColor(color);
	wallHelper->drawRect(0, 0, 254, 380, 521, 9, 3);
	//foreground
	wallHelper->setColor(0xFFFFFF);
	
	glPopMatrix();	
}
-(bool)insideX:(float)x Y:(float)y
{
	CGPoint pos = CGPointMake(x, y);
	pos = CGPointApplyAffineTransform(pos, CGAffineTransformInvert(currentTranslation));
	return (pos.x>frame.origin.x && pos.y>frame.origin.y && pos.x<frame.origin.x+frame.size.width && pos.y<frame.origin.y+frame.size.height);
}
@end
