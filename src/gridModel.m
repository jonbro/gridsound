//
//  gridModel.m
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "gridModel.h"


@implementation gridModel
@synthesize steps;
@synthesize currentSample;
-(id)init
{
	self = [super init];
	steps = [[NSMutableArray alloc]initWithCapacity:8];
	for(int i=0;i<8;i++){
		NSNumber *step = [NSNumber numberWithInt:i];
		[steps addObject:step];
	}
	currentSample = [[NSNumber alloc]initWithInt:0];
	return self;
}
-(void)encodeWithCoder:(NSCoder *)coder{
	[coder encodeObject:currentSample forKey:@"currentSample"];
	[coder encodeObject:[[NSArray alloc]initWithArray:steps] forKey:@"steps"];
}
- (id)initWithCoder:(NSCoder *)coder;
{
	self = [[gridModel alloc] init];
    if (self != nil)
    {
		currentSample = [coder decodeObjectForKey:@"currentSample"];
		steps = [[coder decodeObjectForKey:@"steps"] mutableCopy];
    }
    return self;
}
@end
