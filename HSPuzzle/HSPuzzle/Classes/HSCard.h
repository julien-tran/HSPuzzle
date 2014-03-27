//
//  HSCard.h
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HSHero;

@interface HSCard : NSManagedObject

@property (nonatomic, retain) NSNumber * manaCost;
@property (nonatomic, retain) HSHero *hero;

@end
