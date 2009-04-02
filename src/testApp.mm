
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
	NSMutableArray *instrumentGroup = [[NSMutableArray alloc]initWithCapacity:2];

	[player setInstrumentGroup: instrumentGroup];
	
	SampleInstrument *inMemoryAudioFile = [[SampleInstrument alloc]init];
	//open the a wav file from the application resources
	[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:@"reggae_174" ofType:@"wav"]];
	//set the players inMemoryAudioFile
	[[player instrumentGroup] addObject:inMemoryAudioFile];
	[inMemoryAudioFile reset];

	inMemoryAudioFile = [[SampleInstrument alloc]init];
	//open the a wav file from the application resources
	[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:@"amen_174" ofType:@"wav"]];
	//set the players inMemoryAudioFile
	[[player instrumentGroup] addObject:inMemoryAudioFile];
	[inMemoryAudioFile reset];
	
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
	ofSetColor(0xBC2F2A);
	for(int i = 0; i < 4; i++){
		for(int j = 0; j < 2; j++){
			ofRect(i*80, j*80, 78, 78);		
		}
	}
	ofSetColor(0xFEF14C);
	for(int i = 0; i < 4; i++){
		for(int j = 0; j < 2; j++){
			ofRect(i*80, j*80+160, 78, 78);		
		}
	}
	// #418845
	ofSetColor(0x418845);
	for(int i = 0; i < 4; i++){
		ofRect(i*80, 320, 78, 78);		
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
	
	//[[player inMemoryAudioFile] setNote:(int)y/40];
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


