//
//  HSDataCenter.h
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSDataCenter : NSObject

+ (instancetype)sharedInstance;
+ (NSArray*)heroIDList;

@end