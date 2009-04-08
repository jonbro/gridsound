
@interface MoogFilter : NSObject {
	float cutoff;
	float res;
	float fs;
	float y1,y2,y3,y4;
	float oldx;
	float oldy1,oldy2,oldy3;
	float x;
	float r;
	float p;
	float k;
}

-(void)calc;
-(float)process:(float)input;

@property float cutoff;
@property float res;

@end