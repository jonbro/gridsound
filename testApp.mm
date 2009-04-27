
#include "testApp.h"

const char *notes__[12] = {
	"C ","C#","D ","D#","E ","F ","F#","G ","G#","A ","A#","B " 
} ;


//--------------------------------------------------------------
void testApp::setup(){	
	
	ofBackground(235, 254, 241);
	ofSetBackgroundAuto(true);
	
	// touch events will be sent to myTouchListener
	ofxMultiTouch.addListener(this);

	//setup sound
	player = [[RemoteIOPlayer alloc]init];
	//initialise the audio player
	[player intialiseAudio];
	
	mainController = [[parentController alloc] init];
	for(int i=0;i<6;i++){
		[mainController addChild:[[gridController alloc]init:player]];
	}
	
	
	//initialise the inMemoryAudiofile (holds a wav file in memory)
	NSMutableArray *instrumentGroup = [[NSMutableArray alloc]initWithCapacity:2];
	[player setInstrumentGroup: instrumentGroup];
	[instrumentGroup release];
	
	SampleInstrument *inMemoryAudioFile = [[SampleInstrument alloc]init];
	//open the a wav file from the application resources
	[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:@"bass_stem" ofType:@"wav"]];
	//set the controllers on the first instrument
	[inMemoryAudioFile.controllers setObject:[mainController.children objectAtIndex:0] forKey:@"lpof"];
	[inMemoryAudioFile.controllers setObject:[mainController.children objectAtIndex:3] forKey:@"fcut"];
	inMemoryAudioFile.volume = 80;
	[[mainController.children objectAtIndex:0] release];
	[[mainController.children objectAtIndex:3] release];

	//set the players inMemoryAudioFile
	[[player instrumentGroup] addObject:inMemoryAudioFile];
	[inMemoryAudioFile reset];
	[inMemoryAudioFile release];
	
	// audio file 2
	inMemoryAudioFile = [[SampleInstrument alloc]init];
	//open the a wav file from the application resources
	[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:@"drum_stem" ofType:@"wav"]];

	//set the controllers on the first instrument
	inMemoryAudioFile.volume = 80;
	[inMemoryAudioFile.controllers setObject:[mainController.children objectAtIndex:1] forKey:@"lpof"];
	[inMemoryAudioFile.controllers setObject:[mainController.children objectAtIndex:4] forKey:@"fcut"];
	[[mainController.children objectAtIndex:1] release];
	[[mainController.children objectAtIndex:4] release];
	
	//set the players inMemoryAudioFile
	[[player instrumentGroup] addObject:inMemoryAudioFile];
	[inMemoryAudioFile reset];
	[inMemoryAudioFile release];
	
	
	// audio file 3
	inMemoryAudioFile = [[SampleInstrument alloc]init];
	//open the a wav file from the application resources
	[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:@"note" ofType:@"wav"]];
	inMemoryAudioFile.volume = 80;
	//set the controllers on the first instrument
	[inMemoryAudioFile.controllers setObject:[mainController.children objectAtIndex:2] forKey:@"note"];
	[inMemoryAudioFile.controllers setObject:[mainController.children objectAtIndex:5] forKey:@"lpof"];
	[[mainController.children objectAtIndex:2] release];
	[[mainController.children objectAtIndex:5] release];
	//set the players inMemoryAudioFile
	[[player instrumentGroup] addObject:inMemoryAudioFile];
	[inMemoryAudioFile reset];
	[inMemoryAudioFile release];

	currentGrid = 0;
	
	[player start];
//	[player setMuteChannel:1];
}


//--------------------------------------------------------------
void testApp::update(){
}

//--------------------------------------------------------------
void testApp::draw(){
	[mainController render];
}
void testApp::exit() {
	// need to dealloc all my shit.
	[player stop];
	printf("exit()\n");
}

void testApp::setOffset(float x, float y){
}
void testApp::startAccell(){
}
void testApp::stopAccell(){
}
//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){
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
	//printf("frameRate: %.3f, frameNum: %i\n", ofGetFrameRate(), ofGetFrameNum());
}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){
	
}

//--------------------------------------------------------------
void testApp::touchDown(float x, float y, int touchId, ofxMultiTouchCustomData *data){	
	[mainController touchDownX:x y:y touchId:touchId];
}
//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	[mainController touchDownX:x y:y touchId:touchId];
}
//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	//printf("touch %i double tap at (%i,%i)\n", touchId, x,y);
}


