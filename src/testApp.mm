
#include "testApp.h"

const char *notes__[12] = {
	"C ","C#","D ","D#","E ","F ","F#","G ","G#","A ","A#","B " 
} ;

ofTrueTypeFont sampleFont;
ofTrueTypeFont teleType;
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
	teleType.loadFont("TELETYPE.TTF", 10);
	//setup sound
	player = [[RemoteIOPlayer alloc]init];

	bank = [[bankController alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];

	//initialise the audio player
	[player intialiseAudio];
	
	instrumentGroup = [[NSMutableArray alloc]initWithCapacity:3];
	
	NSMutableArray *samplePool = player.samplePool;
	
	[player setInstrumentGroup:instrumentGroup];
	mainC = [[mainController alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	
	[bank setPlayer:player];
	mainC.bankC = bank;

	parentC = [[parentController alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[parentC setInstrumentGroup:instrumentGroup];
	mainC.parentC = parentC;
	
	phraseC = [[phraseController alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	mainC.phraseC = phraseC;	

	menuC = [[menuController alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	mainC.menuC = menuC;
	infoC = [[infoController alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	mainC.infoC = infoC;
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
	//[player start];
	
	[Events setFirstResponder:mainC];

}

void testApp::lostFocus(){
	[player stop];
}
void testApp::gotFocus(){
	//[player start];
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
	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:aModel] forKey:@"savedArray"];
}
void testApp::loadDefaults(){
	NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
	NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"savedArray"];
	if (dataRepresentingSavedArray != nil)
	{
		aModel = [[NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray] retain];
		if([aModel isKindOfClass:[appModel class]]){
			[mainC setApp:[aModel retain]];
		}else{
			aModel = [[appModel alloc] init];
			[mainC setApp:[aModel retain]];
		}		
	}else{
		aModel = [[appModel alloc] init];
		[mainC setApp:[aModel retain]];
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
