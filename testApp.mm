
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

	ofxAccelerometer.setup();

	
	//setup sound
	player = [[RemoteIOPlayer alloc]init];
	//initialise the audio player
	[player intialiseAudio];
	
//	NSArray *sampleArray = [[NSArray alloc] initWithObjects:@"Bass1", @"Bass2", @"Drums1", @"Drums2", @"Drums3", @"Drums4", @"Glock1", @"Glock2", @"Glock3", @"Glock4", @"OldBeat", nil];
//	NSArray *noteSampleArray = [[NSArray alloc] initWithObjects:@"blg", @"bng", @"chm", @"cht", @"crh", @"plk", @"tnk", @"wmm", nil];

	NSArray *sampleArray = [[NSArray alloc] initWithObjects:@"hr_bass1", @"hr_bass2", @"hr_bass3", @"hr_bass4", @"hr_bass5", @"hr_bass6", @"hr_drums1", @"hr_drums2", @"hr_drums3", @"hr_drums4", @"hr_drums5", @"hr_drums6", @"hr_vox1", @"hr_vox2", @"hr_vox3", @"hr_vox4", @"hr_vox5", nil];
	NSArray *noteSampleArray = [[NSArray alloc] initWithObjects:@"blg", @"bng", @"chm", @"cht", @"crh", @"plk", @"tnk", @"wmm", nil];

	
	NSMutableArray *instrumentGroup = [[NSMutableArray alloc]initWithCapacity:3];
	NSMutableArray *samplePool = [[NSMutableArray alloc]initWithCapacity:3];
	
	[player setInstrumentGroup: instrumentGroup];
	
	for(int i=0;i<[sampleArray count];i++){
		InMemoryAudioFile *inMemoryAudioFile = [[InMemoryAudioFile alloc]init];
		//open the a wav file from the application resources
		[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:[sampleArray objectAtIndex:i] ofType:@"wav"]];
		[samplePool addObject:[inMemoryAudioFile retain]];
	}
	for(int i=0;i<[noteSampleArray count];i++){
		InMemoryAudioFile *inMemoryAudioFile = [[InMemoryAudioFile alloc]init];
		//open the a wav file from the application resources
		[inMemoryAudioFile open:[[NSBundle mainBundle] pathForResource:[noteSampleArray objectAtIndex:i] ofType:@"wav"]];
		[samplePool addObject:[inMemoryAudioFile retain]];
	}
	
	mainController = [[parentController alloc] init];
	[mainController setInstrumentGroup:instrumentGroup];
	[instrumentGroup release];

	for(int i=0;i<9;i++){
		gridController *_gControl = [[gridController alloc]init:player loopSamples:[sampleArray retain] noteSamples:[noteSampleArray retain]];
		[mainController addChild:_gControl];
	}
	
	
	for(int i=0;i<3;i++){
		SampleInstrument *sampleInstrument = [[SampleInstrument alloc]init];
		sampleInstrument.samplePool = samplePool;
		[sampleInstrument.controllers setObject:[[mainController.children objectAtIndex:i]retain] forKey:@"lpof"];
		[sampleInstrument.controllers setObject:[[mainController.children objectAtIndex:i+3]retain] forKey:@"rtgr"];
		[sampleInstrument.controllers setObject:[[mainController.children objectAtIndex:i+6]retain] forKey:@"fcut"];
		[[sampleInstrument.controllers objectForKey:@"fcut"] setAll:7];
		[[sampleInstrument.controllers objectForKey:@"rtgr"] setAll:0];

		sampleInstrument.volume = 80;
		sampleInstrument.currentSample = i;
		
		[[mainController.children objectAtIndex:i] setSample:i*6];
		
		//set the players inMemoryAudioFile
		[[player instrumentGroup] addObject:sampleInstrument];
		
		[sampleInstrument reset];
		[sampleInstrument release];
	}
		
	currentGrid = 0;	
	[player start];
}


//--------------------------------------------------------------
void testApp::update(){
	[mainController update];
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
	[mainController touchUpX:x y:y touchId:touchId];
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	//printf("touch %i double tap at (%i,%i)\n", touchId, x,y);
}


