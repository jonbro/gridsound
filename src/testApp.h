#pragma once

#include "ofMain.h"
#include "ofxAccelerometer.h"
#include "ofxMultiTouch.h"
#import "RemoteIOPlayer.h"
#import "Phrase.h"

class testApp : public ofSimpleApp, public ofxMultiTouchListener {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void keyPressed(int key) {}
	void keyReleased(int key)  {}
	void mouseMoved(int x, int y );
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased();
	void mouseReleased(int x, int y, int button );
	
	void touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	
	void setOffset(float x, float y);	
	void startAccell();	
	void stopAccell();
	
	ofImage bikers;
	ofImage gears;
	ofImage tdf;
	ofImage tdfSmall;
	ofImage transparency;
	ofImage bikeIcon;
	ofImage theLion;

	RemoteIOPlayer *player;
	
	bool accellOn;
	ofPoint initialPos;
	
	NSMutableArray *phrases;
	
	int steps[8];
	
};



