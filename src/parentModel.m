//
//  parentModel.m
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "parentModel.h"


@implementation parentModel

@synthesize gridModels, currentState, currentGrid;

-(id)init
{
	self = [super init];
	currentState = [[[NSMutableString alloc] initWithString:@"small"] retain];
	gridModels = [[NSMutableArray alloc]initWithCapacity:1];
	for(int i=0;i<6;i++){
		[gridModels addObject:[[gridModel alloc]init]];
	}
	currentGrid = [NSNumber numberWithInt:0];
	return self;
}
- (void)setCurrentState:(NSString*)aValue
{
	[currentState autorelease];
	currentState = [aValue copy];
}
- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:currentState forKey:@"currentState"];
	[coder encodeObject:currentGrid forKey:@"currentGrid"];
	[coder encodeObject:gridModels forKey:@"gridModels"];
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
    return self;
}

@end
