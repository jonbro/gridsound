//
//  gridModel.m
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "gridModel.h"


@implementation gridModel
@synthesize steps, mutes, currentSample;

-(id)init
{
	self = [super init];
	steps = [[NSMutableArray alloc]initWithCapacity:8];
	for(int i=0;i<8;i++){
		NSNumber *step = [NSNumber numberWithInt:i];
		[steps addObject:step];
	}
	mutes = [[NSMutableArray alloc]initWithCapacity:8];
	for(int i=0;i<8;i++){
		NSNumber *mute = [NSNumber numberWithInt:0];
		[mutes addObject:mute];
	}
	currentSample = [NSNumber numberWithInt:0];
	return self;
}
-(void)encodeWithCoder:(NSCoder *)coder{
	[coder encodeObject:currentSample forKey:@"currentSample"];
	[coder encodeObject:[NSArray arrayWithArray:steps] forKey:@"steps"];
	[coder encodeObject:[NSArray arrayWithArray:mutes] forKey:@"mutes"];
}
- (id)initWithCoder:(NSCoder *)coder;
{
	self = [self init];
	[currentSample release];
	currentSample = [[coder decodeObjectForKey:@"currentSample"] retain];
	[steps release];
	steps = [[[coder decodeObjectForKey:@"steps"] mutableCopy] retain];
	[mutes release];
	mutes = [[[coder decodeObjectForKey:@"mutes"] mutableCopy] retain];
    return self;
}
@end
