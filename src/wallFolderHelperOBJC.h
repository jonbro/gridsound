#import <Foundation/Foundation.h>
#import "ofxMSAShape3D.h"
#import "ofMain.h"
#import "texturePool.h"

@interface wallFolderHelperOBJC : NSObject {
	ofxMSAShape3D *myShape;
	int currentFrame, direction, startMove, startFrame, zoomDirection, startZoom, offset_x_target, offset_y_target, zoomSpeed, zoomSpeedSecondary, infoDirection, infoPosition, infoStart;
	float cloud1XPosition, cloud2XPosition, cloud3XPosition;
	float balloonX, balloonY, scaleTarget;	
}

-(id) init;
-(void)drawScalerWallOffsetX:(int)_x offsetY:(int)_y scale:(int)_scale;

@end