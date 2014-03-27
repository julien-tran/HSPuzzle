//
//  HSMinion.h
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "HSCard.h"

@class HSHero;

@interface HSMinion : HSCard

@property (nonatomic, retain) NSNumber * healthOriginal;
@property (nonatomic, retain) NSNumber * attackOriginal;
@property (nonatomic, retain) NSNumber * healthModified;
@property (nonatomic, retain) NSNumber * attackModified;
@property (nonatomic, retain) NSNumber * healthCurrent;
@property (nonatomic, retain) NSNumber * attackCurrent;
@property (nonatomic, retain) NSNumber * isStealth;
@property (nonatomic, retain) NSNumber * divineShield;
@property (nonatomic, retain) NSNumber * isTaunt;
@property (nonatomic, retain) NSNumber * isFrozen;
@property (nonatomic, retain) NSNumber * isLegendary;
@property (nonatomic, retain) HSHero *heroSummoned;

@end
