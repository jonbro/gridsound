
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
	
	NSArray *sampleArray = [[NSArray alloc] initWithObjects:@"bass_stem", @"drum_stem", @"note", nil];
	NSMutableArray *instrumentGroup = [[NSMutableArray alloc]initWithCapacity:3];
	NSMutableArray *samplePool = [[NSMutableArray alloc]initWithCapacity:3];
	[player setInstrumentGroup: instrumentGroup];	
	[instrumentGroup release];	
	for(int i=0;i<2;i++){
		SampleInstrument *sampleInstrument = [[SampleInstrument alloc]init];
		InMemoryAudioFile *inMemoryAudioFile = [[InMemoryAudioFile alloc]init];
		
		//open the a wav file from the application resources
		[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:[sampleArray objectAtIndex:i] ofType:@"wav"]];
		
		[samplePool addObject:inMemoryAudioFile];
		sampleInstrument.samplePool = samplePool;
		
		//set the controllers on the first instrument
		if(i!=2){
			[sampleInstrument.controllers setObject:[[mainController.children objectAtIndex:i]retain] forKey:@"lpof"];
		}else{
			[sampleInstrument.controllers setObject:[[mainController.children objectAtIndex:i]retain] forKey:@"note"];
		}
		[sampleInstrument.controllers setObject:[[mainController.children objectAtIndex:i+3]retain] forKey:@"fcut"];
		sampleInstrument.volume = 80;
		sampleInstrument.currentSample = i;
		
		//set the players inMemoryAudioFile
		[[player instrumentGroup] addObject:sampleInstrument];
		
		[sampleInstrument reset];
		[sampleInstrument release];
	}
	[sampleArray dealloc];
	
	currentGrid = 0;	
	[player start];
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


