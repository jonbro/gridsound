
#include "testApp.h"


//--------------------------------------------------------------
void testApp::setup(){	
	
	ofBackground(50, 50, 50);
	ofSetBackgroundAuto(true);
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	// touch events will be sent to myTouchListener
	ofxMultiTouch.addListener(this);
		

	//setup sound
	player = [[RemoteIOPlayer alloc]init];
	//initialise the audio player
	[player intialiseAudio];
	//initialise the inMemoryAudiofile (holds a wav file in memory)
	SampleInstrument *inMemoryAudioFile = [[SampleInstrument alloc]init];
	//open the a wav file from the application resources
	[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:@"MS20-VCO1-Tri-C1" ofType:@"wav"]];
	//set the players inMemoryAudioFile
	[player setInMemoryAudioFile: inMemoryAudioFile];
	[[player inMemoryAudioFile] reset];
	[player start];
	
}


//--------------------------------------------------------------
void testApp::update(){
//	int currentTick = player.tick;
	//currentStep = fmod(currentStep++, 16.0f);
	//NSLog(@"current Step %i",  [player getTick]);

//	int newStep = fmod(player.tick, 16);
//	if(currentStep != newStep){
//		currentStep = newStep;
//		[player inMemoryAudioFile].note = [phrase getStep:currentStep];
//	}
	
}

//--------------------------------------------------------------
void testApp::draw(){	
	for(int i = 0; i < 16; i++){
		ofSetColor(0xAFCFCF);
		ofRect(0, i*ofGetHeight()/16, ofGetWidth()/2, i*ofGetHeight()/16-2);
	}
	
}

void testApp::exit() {
	printf("exit()\n");
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
	// this will never get called 
	
}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){
}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){
	ofEnableSmoothing();
}

//--------------------------------------------------------------
void testApp::mouseReleased(){
//	printf("mouseReleased\n");
	printf("frameRate: %.3f, frameNum: %i\n", ofGetFrameRate(), ofGetFrameNum());
}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){
	
}

//--------------------------------------------------------------
void testApp::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	NSLog(@"touch %i down at (%i,%i)\n", touchId, (int)x, (int)y);
	[[player inMemoryAudioFile] setNote:(int)y/40];
	//printf("touch %i down at (%i,%i)\n", touchId, x,y);
}
//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	printf("touch %i moved at (%i,%i)\n", touchId, x,y);
}
//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	printf("touch %i up at (%i,%i)\n", touchId, x,y);
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	printf("touch %i double tap at (%i,%i)\n", touchId, x,y);
}


