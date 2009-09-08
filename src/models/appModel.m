//
//  appModel.m
//  mujik
//
//  Created by jonbroFERrealz on 9/7/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "appModel.h"

@implementation appModel

@synthesize currentBank, currentScreen;

-(id)init
{
	self = [super init];
	
	currentBank = [[bankModel alloc] init];
	currentScreen = @"switchToMain";
	
	return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:currentBank forKey:@"currentBank"];
	[coder encodeObject:currentScreen forKey:@"currentScreen"];
}
- (id)initWithCoder:(NSCoder *)coder
{
	self = [self init];
	self.currentBank = [[coder decodeObjectForKey:@"currentBank"] copy];	
	self.currentScreen = [[coder decodeObjectForKey:@"currentScreen"] copy];	
    return self;
}
@end
