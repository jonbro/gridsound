#pragma once

#include "ofMain.h"
#include "ofxAccelerometer.h"
#include "ofxMultiTouch.h"
#include "gridControllerHelper.h"
#import "RemoteIOPlayer.h"
#import "Phrase.h"
#import "parentController.h"
#import "gridController.h"
#import "bankController.h"
#import "mainController.h"
#import "Events.h"

class testApp : public ofSimpleApp, public ofxMultiTouchListener {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	void gotFocus();
	void lostFocus();
	
	void keyPressed(int key) {}
	void keyReleased(int key)  {}
	void mouseMoved(int x, int y );
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased();
	void mouseReleased(int x, int y, int button );
	void saveDefaults();
	void loadDefaults();
	void touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	void touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data = NULL);
	
	void setOffset(float x, float y);	
	void startAccell();	
	void stopAccell();
	void drawRastaCutter();
	ofTrueTypeFont	littlefont;
	RemoteIOPlayer	*player;
	gridControllerHelper *gcHelper;
	parentModel *pModel;
	mainController *mainC;
	NSMutableArray *instrumentGroup;
	ofImage belt;
	bool			imageCount;
	bool			accellOn;
	ofPoint			initialPos;
	
	// stuff for the phrase controller
	int				currentGrid;
	bool			editing;
	
	//random optomization shit
	int yHeight;
	int half_yHeight;
	int yPos;
	
	parentController *parentC;
	bankController *bank;
	string noteArray[12];
	
};

extern const char *notes__[12] ;

inline void note2char(char d,char *s) {
	int oct=d/12-2 ;
	int note=d%12 ;
	strcpy(s,notes__[note]) ;
	if (oct<0) {
		s[2]='-' ;
        oct=-oct ;
    } else {		
		s[2]=' ' ;
    }
	s[3]='0'+oct ;
} ;

