//
//  HSDataCenter.m
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import "HSDataCenter.h"

@implementation HSDataCenter

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSArray*)heroIDList
{
    return @[@"druid", @"hunter", @"mage", @"priest"];
}

@end