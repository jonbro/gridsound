
#include "testApp.h"

const char *notes__[12] = {
	"C ","C#","D ","D#","E ","F ","F#","G ","G#","A ","A#","B " 
} ;


//--------------------------------------------------------------
void testApp::setup(){	
	
	ofBackground(0, 0, 0);
	ofSetBackgroundAuto(true);
	
	// touch events will be sent to myTouchListener
	ofxMultiTouch.addListener(this);
	
	for(int i=0;i<8;i++){
		steps[i] = i;
	}

	// load font
	//good at 16 or 8
	
	littlefont.loadFont(ofToDataPath("FreeSans.ttf"), 10, true, false);
//	littlefont.loadFont(ofToDataPath("04B_11__.ttf"), 8, false, false);
	//theLion.loadImage("the_lion.jpg");

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
	yHeight = ((480-60)/16)-1;
	half_yHeight = yHeight/2;
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
	// draw menu bar

	ofSetColor(0xFF0000);
	ofRect(0, 0, 320, 60);

	ofSetColor(0x000000);
	
	char fpsStr[255]; // an array of chars
	sprintf(fpsStr, "frame rate: %f", ofGetFrameRate());
	littlefont.drawString(fpsStr, 100,100);
	
	for(int i =0;i<16;i++){
		yPos = (yHeight+1)*i;
		if(editing && currentEdit == i){
			ofSetColor(0xFF0000);			
		}else{
			ofSetColor(0x000000);
		}
		ofRect(0, yPos+60, 320, yHeight);
		ofSetColor(0xFFFFFF);

		char data=10;
		char buffer[4];
		note2char(data,buffer);

		littlefont.drawString(buffer, 60, yPos+60+half_yHeight+2);
	}
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
	//ofEnableSmoothing();
}

//--------------------------------------------------------------
void testApp::mouseReleased(){
	printf("frameRate: %.3f, frameNum: %i\n", ofGetFrameRate(), ofGetFrameNum());
}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){
	
}

//--------------------------------------------------------------
void testApp::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data){	
	if(touchId == 0 && y>60){
		editing = true;
		currentEdit = (int)((y-60)/(480.0-60.0)*16.0);
	}
}
//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	if(touchId == 0 && y>60){
		editing = true;
		currentEdit = (int)((y-60)/(480.0-60.0)*16.0);
	}	
//	printf("touch %i moved at (%i,%i)\n", touchId, x,y);
}
//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	if(touchId == 0){
		editing = false;
	}
	//printf("touch %i up at (%i,%i)\n", touchId, x,y);
	//[[[player instrumentGroup] objectAtIndex:0] setLoopOffsetStartPercentage:0.0 endPercentage:1.0];
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	printf("touch %i double tap at (%i,%i)\n", touchId, x,y);
}


