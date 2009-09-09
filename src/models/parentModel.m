//
//  parentModel.m
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "parentModel.h"


@implementation parentModel

@synthesize gridModels, currentState, currentGrid, volumes, mutes, directions, currentSamples;

-(id)init
{
	self = [super init];
	currentState = [[[NSMutableString alloc] initWithString:@"small"] retain];
	gridModels = [[NSMutableArray alloc]initWithCapacity:1];
	volumes = [[NSMutableArray alloc]initWithCapacity:1];
	mutes = [[NSMutableArray alloc]initWithCapacity:1];
	directions = [[NSMutableArray alloc]initWithCapacity:1];
	currentSamples = [[NSMutableArray alloc]initWithCapacity:1];
	
	for(int i=0;i<6;i++){
		[gridModels addObject:[[gridModel alloc]init]];
	}
	for(int i=0;i<3;i++){
		[volumes addObject:[NSNumber numberWithInt:128]];
		[mutes addObject:[NSNumber numberWithBool:NO]];
		[directions addObject:[NSNumber numberWithBool:YES]];
		if(i==0){
			[currentSamples addObject:[NSNumber numberWithInt:5]];
		}
		if(i==1){
			[currentSamples addObject:[NSNumber numberWithInt:0]];
		}
		if(i==2){
			[currentSamples addObject:[NSNumber numberWithInt:7]];
		}
	}
	currentGrid = [NSNumber numberWithInt:0];
	return self;
}
- (void)setCurrentState:(NSString*)aValue
{
	[currentState autorelease];
	currentState = [aValue copy];
}
- (id)copyWithZone:(NSZone *)zone
{
	parentModel *copy = [[[self class] allocWithZone: zone] init];
	copy.currentState = [self.currentState mutableCopy];
	copy.gridModels = [self.gridModels mutableCopy];
	copy.volumes = [self.volumes mutableCopy];
	copy.mutes = [self.mutes mutableCopy];
	copy.directions = [self.directions mutableCopy];
	copy.currentSamples = [self.currentSamples mutableCopy];
	return copy;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:currentState forKey:@"currentState"];
	[coder encodeObject:currentGrid forKey:@"currentGrid"];
	[coder encodeObject:gridModels forKey:@"gridModels"];
	[coder encodeObject:volumes forKey:@"volumes"];
	[coder encodeObject:directions forKey:@"directions"];
	[coder encodeObject:currentSamples forKey:@"currentSamples"];
	[coder encodeObject:mutes forKey:@"mutes"];
}
-(NSNumber*)currentGrid
{
	return currentGrid;
}
- (id)initWithCoder:(NSCoder *)coder
{
	self = [self init];
	self.currentState = [[coder decodeObjectForKey:@"currentState"] copy];	
	self.currentGrid = [[coder decodeObjectForKey:@"currentGrid"] retain];
	self.gridModels = [[coder decodeObjectForKey:@"gridModels"] retain];
	self.volumes = [[coder decodeObjectForKey:@"volumes"] retain];
	self.currentSamples = [[coder decodeObjectForKey:@"currentSamples"] retain];
	self.directions = [[coder decodeObjectForKey:@"directions"] retain];
	self.mutes = [[coder decodeObjectForKey:@"mutes"] retain];
    return self;
}

@end
