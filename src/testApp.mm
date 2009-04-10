
#include "testApp.h"


//--------------------------------------------------------------
void testApp::setup(){	
	
	ofBackground(50, 50, 50);
	ofSetBackgroundAuto(true);
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	// touch events will be sent to myTouchListener
	ofxMultiTouch.addListener(this);
	
	for(int i=0;i<8;i++){
		steps[i] = i;
	}

	// load font
	//good at 16 or 8
	
	littlefont.loadFont(ofToDataPath("FreeSans.ttf"),10, true, false);
	theLion.loadImage("the_lion.jpg");

	//setup sound
	player = [[RemoteIOPlayer alloc]init];
	//initialise the audio player
	[player intialiseAudio];
	
	NSMutableArray *phrases = [[NSMutableArray alloc]initWithCapacity:16];
	for(int i=0;i<16;i++){
		Phrase *newPhrase = [[Phrase alloc]init];
		[phrases addObject:newPhrase];
	}
	
	
	//initialise the inMemoryAudiofile (holds a wav file in memory)
	NSMutableArray *instrumentGroup = [[NSMutableArray alloc]initWithCapacity:2];
	
	[player setInstrumentGroup: instrumentGroup];
	
	SampleInstrument *inMemoryAudioFile = [[SampleInstrument alloc]init];
	//open the a wav file from the application resources
	[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:@"square" ofType:@"wav"]];
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
	[player setMuteChannel:1];
	
	for(int i=0;i<8;i++){
		[player setStep:i stepValue:i];
	}
	accellOn = false;
}


//--------------------------------------------------------------
void testApp::update(){
	if(accellOn){
		ofPoint currentPosition = ofxAccelerometer.getOrientation();
		[[[player instrumentGroup] objectAtIndex:1] setNote:(int)((currentPosition.y-initialPos.y)/20)];
	}
}

//--------------------------------------------------------------
void testApp::draw(){
	for(int i =0;i<16;i++){
		ofSetColor(0x00FF00);
		littlefont.drawString("C-4", 10,i*480/16+10);
	}
}
void testApp::drawRastaCutter(){
	//rasta pallete
	// ofSetColor(0xBC2F2A);
	// ofSetColor(0xFEF14C);
	// ofSetColor(0x418845);
	
	// designy pallet
	// 0xEB008B
	// 0x45FF00
	
	// draw the channel looper
	ofSetColor(0xEB008B);
	ofFill();
	for(int i = 0; i < 8; i++){
		for(int j = 0; j < 8; j++){
			ofSetColor(0xBC2F2A);
			ofFill();
			if([player getStep:j] != i){
				if(fmod(player.tick, 8)!=j){
					ofSetColor(0xFEF14C);
				}else{
					ofSetColor(0x418845);
				}
			}
			ofRect(i*40+2, j*40+2, 35, 35);		
		}
	}
	
	// draw the mute boxes
	ofSetColor(0x418845);
	for(int i=0;i<2;i++){
		id currentInstrument = [[player instrumentGroup] objectAtIndex:i];
		if([currentInstrument volume]==255){
			ofFill();
		}else{
			ofNoFill();
		}
		ofRect(i*160+2, 320+2, 155, 80);
	}
	theLion.draw(0,400);
	
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
void testApp::startAccell(){
	accellOn = true;
	initialPos = ofxAccelerometer.getOrientation();
}
void testApp::stopAccell(){
	accellOn = false;	
	[[[player instrumentGroup] objectAtIndex:1] setNote:0];
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
			[player setMuteChannel:0];
		}else{
			[player setMuteChannel:1];
		}
	}else{
		// pass to accell handler
		//startAccell();
		
	}
	//[[player inMemoryAudioFile] setNote:(int)y/40];
	//printf("touch %i down at (%i,%i)\n", touchId, x,y);
}
//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	if(y<320){
		setOffset(x, y);
		stopAccell();
	}
//	printf("touch %i moved at (%i,%i)\n", touchId, x,y);
}
//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	stopAccell();
	//printf("touch %i up at (%i,%i)\n", touchId, x,y);
	//[[[player instrumentGroup] objectAtIndex:0] setLoopOffsetStartPercentage:0.0 endPercentage:1.0];
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	printf("touch %i double tap at (%i,%i)\n", touchId, x,y);
}


