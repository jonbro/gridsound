
#include "testApp.h"


//--------------------------------------------------------------
void testApp::setup(){	
	
	ofBackground(255, 255, 255);
	ofSetBackgroundAuto(true);
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	// touch events will be sent to myTouchListener
	ofxMultiTouch.addListener(this);
	
	for(int i=0;i<8;i++){
		steps[i] = i;
	}

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
	
	for(int i=0;i<8;i++){
		[player setStep:i stepValue:i];
	}
	
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
	//ofSetColor(0xBC2F2A);

	// draw the channel looper
	ofSetColor(0xEB008B);
	for(int i = 0; i < 8; i++){
		for(int j = 0; j < 8; j++){
			ofSetColor(0xEB008B);
			if([player getStep:j] == i){
				ofFill();
			}else{
				if(fmod(player.tick, 8)!=j){
					ofSetColor(0, 0, 0);
				}
				ofNoFill();
			}
			ofRect(i*40+2, j*40+2, 35, 35);		
		}
	}
	
	// draw the mute boxes
	ofSetColor(0x45FF00);
	for(int i=0;i<2;i++){
		id currentInstrument = [[player instrumentGroup] objectAtIndex:i];
		if([currentInstrument volume]==255){
			ofFill();
		}else{
			ofNoFill();
		}
		ofRect(i*160, 320, 155, 80);
	}
	/*ofSetColor(0xFEF14C);
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
	*/
}

void testApp::exit() {
	printf("exit()\n");
}

void testApp::setOffset(float x, float y){
	[player setStep:(int)(y/320.0*8.0) stepValue:(int)(x/320.0*8.0)];
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
	if(y<320){
		setOffset(x, y);
	}else if(y<400){
		if(x<160){
			NSLog(@"here");
			[player setMuteChannel:0];
		}else{
			[player setMuteChannel:1];
		}
	}
	//[[player inMemoryAudioFile] setNote:(int)y/40];
	//printf("touch %i down at (%i,%i)\n", touchId, x,y);
}
//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	if(y<320){
		setOffset(x, y);
	}
//	printf("touch %i moved at (%i,%i)\n", touchId, x,y);
}
//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	printf("touch %i up at (%i,%i)\n", touchId, x,y);
	[[[player instrumentGroup] objectAtIndex:0] setLoopOffsetStartPercentage:0.0 endPercentage:1.0];
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	printf("touch %i double tap at (%i,%i)\n", touchId, x,y);
}


