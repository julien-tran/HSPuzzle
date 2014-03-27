//
//  HSWeapon.h
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "HSCard.h"

@class HSHero;

@interface HSWeapon : HSCard

@property (nonatomic, retain) NSNumber * attackOriginal;
@property (nonatomic, retain) NSNumber * attackCurrent;
@property (nonatomic, retain) NSNumber * durabilityOriginal;
@property (nonatomic, retain) NSNumber * durabilityCurrent;
@property (nonatomic, retain) HSHero *heroCarried;

@end
