
#include "testApp.h"

const char *notes__[12] = {
	"C ","C#","D ","D#","E ","F ","F#","G ","G#","A ","A#","B " 
} ;

ofTrueTypeFont sampleFont;
wallFolderHelper *wallHelper;

//--------------------------------------------------------------
void testApp::setup(){	
	
	ofBackground(235, 254, 241);
	ofSetBackgroundAuto(true);
	
	wallHelper = new wallFolderHelper();
	
	ofEnableAlphaBlending();
	
	// touch events will be sent to myTouchListener
	ofxMultiTouch.addListener(this);

	ofxAccelerometer.setup();
		
	sampleFont.loadFont("DejaVuSerifCondensed-Bold.ttf", 11);

	//setup sound
	player = [[RemoteIOPlayer alloc]init];

	bank = [[bankController alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];

	//initialise the audio player
	[player intialiseAudio];
	#ifdef GLOCKVERSION
		NSArray *sampleArray = [[NSArray alloc] initWithObjects:@"Bass1", @"Bass2", @"Bass3", @"Drums1", @"Drums2", @"Drums3", @"Drums4", @"Glock1", @"Glock2", @"Glock3", @"Percussion", nil];
	#endif
	#ifdef HRVERSION
		NSArray *sampleArray = [[NSArray alloc] initWithObjects:@"hr_bass1", @"hr_bass2", @"hr_bass3", @"hr_bass4", @"hr_bass5", @"hr_bass6", @"hr_drums1", @"hr_drums2", @"hr_drums3", @"hr_drums4", @"hr_drums5", @"hr_drums6", @"hr_vox1", @"hr_vox2", @"hr_vox3", @"hr_vox4", @"hr_vox5", nil];
	#endif
	#ifdef GSVERSION
		NSArray *sampleArray = [[NSArray alloc] initWithObjects:@"Bass1", @"Bass2", @"Drums1", @"Drums2", @"Drums3", @"Keys1", @"Keys2", @"Vocals", nil];
	#endif
	#ifdef SWVERSION
		NSArray *sampleArray = [[NSArray alloc] initWithObjects:@"Bass1", @"Bass2", @"Chorus", @"Drums1", @"Drums2", @"Synth1", @"Synth2", @"Synth3", @"Verse1", @"Verse2", @"Verse3", nil];
	#endif
	
	
	
	instrumentGroup = [[NSMutableArray alloc]initWithCapacity:3];
	
	NSMutableArray *samplePool = player.samplePool;
	
	[player setInstrumentGroup:instrumentGroup];
	mainC = [[mainController alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	
	[bank setPlayer:player];
	[bank loadBank:[NSNumber numberWithInt:0]];
	mainC.bankC = bank;

	parentC = [[parentController alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[parentC setInstrumentGroup:instrumentGroup];
	mainC.parentC = parentC;

	menuC = [[menuController alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	mainC.menuC = menuC;

	helpC = [[helpController alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	mainC.helpC = helpC;
	
	[instrumentGroup release];
	
	gcHelper = new gridControllerHelper();
	
	for(int i=0;i<6;i++){
		gridController *_gControl = [[gridController alloc]init:player gcHelper:gcHelper channelNumber:i%3 gridNumber:i];
		[parentC addChild:_gControl];
	}
	
	this->loadDefaults();
	
	imageCount = false;
	for(int i=0;i<3;i++){
		SampleInstrument *sampleInstrument = [[SampleInstrument alloc]init];
		sampleInstrument.samplePool = samplePool;
		[sampleInstrument.controllers setObject:[[parentC.children objectAtIndex:i]retain] forKey:@"lpof"];
		[sampleInstrument.controllers setObject:[[parentC.children objectAtIndex:i+3]retain] forKey:@"rtgr"];
		[[sampleInstrument.controllers objectForKey:@"fcut"] setAll:7];
		[[sampleInstrument.controllers objectForKey:@"rtgr"] setAll:0];
		sampleInstrument.volume = 80;
		sampleInstrument.currentSample = i;
		
		//set the players inMemoryAudioFile
		[[player instrumentGroup] addObject:sampleInstrument];
		
		[sampleInstrument reset];
		[sampleInstrument release];
	}
	currentGrid = 0;
	[player start];
	
	[mainC initialStart];
	[Events setFirstResponder:mainC];

}

void testApp::lostFocus(){
	[player stop];
}
void testApp::gotFocus(){
	[player start];
}

//--------------------------------------------------------------
void testApp::update(){
	[mainC update];
	if(imageCount){
		imageCount = false;
	}else{
		imageCount = true;
	}
}

//--------------------------------------------------------------
void testApp::draw(){
	//[bank render];
	[mainC	render];
	// ofSetColor(255, 255, 255);
}
void testApp::saveDefaults(){
	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:pModel] forKey:@"savedArray"];
}
void testApp::loadDefaults(){
	NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
	NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"savedArray"];
	if (dataRepresentingSavedArray != nil)
	{
		pModel = [[NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray] retain];
		[parentC setModel:pModel];
	}else{
		pModel = [[parentModel alloc]init];
		[parentC setModel:[pModel retain]];
	}	
}

void testApp::exit() {
	this->saveDefaults();
	[player stop];
	NSLog(@"exiting");
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
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.pos = CGPointMake(x, y);
	t_event.touchId = touchId;
	[Events touchDown:t_event];
	[t_event release];
}
//--------------------------------------------------------------
void testApp::touchMoved(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.pos = CGPointMake(x, y);
	t_event.touchId = touchId;
	[Events touchMoved:t_event];
}
//--------------------------------------------------------------
void testApp::touchUp(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.x_pos = x;
	t_event.y_pos = y;
	t_event.pos = CGPointMake(x, y);
	t_event.touchId = touchId;
	[Events touchUp:t_event];
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(float x, float y, int touchId, ofxMultiTouchCustomData *data){
	TouchEvent* t_event = [[TouchEvent alloc]init];
	t_event.pos = CGPointMake(x, y);
	t_event.touchId = touchId;
	[Events touchDoubleTap:t_event];
}
