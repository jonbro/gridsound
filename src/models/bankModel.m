//
//  bankModel.m
//  mujik
//
//  Created by jonbroFERrealz on 9/7/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "bankModel.h"


@implementation bankModel

@synthesize bankName, currentParent, phraseSet;

-(id)init
{
	self = [super init];

	phraseSet = [[NSMutableArray alloc]initWithCapacity:0];
	bankName = [NSMutableString stringWithString:@"Mujik"];
	NSLog(bankName);
	currentParent = [[parentModel alloc] init];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:bankName forKey:@"bankName"];
	[coder encodeObject:phraseSet forKey:@"phraseSet"];
	[coder encodeObject:currentParent forKey:@"currentParent"];
}
- (id)initWithCoder:(NSCoder *)coder
{
	self = [self init];
	self.phraseSet = [[coder decodeObjectForKey:@"phraseSet"] copy];	
	self.currentParent = [[coder decodeObjectForKey:@"currentParent"] copy];	
	self.bankName = [[coder decodeObjectForKey:@"bankName"] copy];	
    return self;
}


@end
