//
//  appModel.m
//  mujik
//
//  Created by jonbroFERrealz on 9/7/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "appModel.h"

@implementation appModel

@synthesize currentBank, currentScreen, version, bankSet;

-(id)init
{
	self = [super init];
	
	currentBank = [[bankModel alloc] init];
	
	currentScreen = [[NSMutableString stringWithString:@"switchToMain"]retain];
	version = [[NSNumber numberWithFloat:1.1]retain];
	bankSet = [[NSMutableArray alloc] initWithCapacity:0];
	
	[bankSet addObject:currentBank];
		
	return self;
}
// when loading bank, check to see if the bank is already in the bankSet and initialize from there
// else create a new bank and store in the bankSet
- (bankModel*)loadBank:(NSMutableString*)bankName
{
	bool foundBank = false;
	for(int i=0;i<[bankSet count];i++){
		if([[[bankSet objectAtIndex:i] bankName] isEqualToString:bankName]){
			currentBank = [bankSet objectAtIndex:i];
			foundBank = true;
		}
	}
	if(!foundBank){
		currentBank = [[bankModel alloc] init];
		[bankSet addObject:currentBank];
	}
	return currentBank;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:currentBank forKey:@"currentBank"];
	[coder encodeObject:version forKey:@"version"];
	[coder encodeObject:bankSet forKey:@"bankSet"];
	[coder encodeObject:currentScreen forKey:@"currentScreen"];
}
- (id)initWithCoder:(NSCoder *)coder
{
	self = [self init];
	
	self.currentBank = [[coder decodeObjectForKey:@"currentBank"] retain];
	self.bankSet = [[coder decodeObjectForKey:@"bankSet"] retain];
	self.currentScreen = [[coder decodeObjectForKey:@"currentScreen"] copy];	
	self.version = [[coder decodeObjectForKey:@"version"] copy];
	
    return self;
}
@end
