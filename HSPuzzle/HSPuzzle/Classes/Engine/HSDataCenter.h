//
//  HSDataCenter.h
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSMinion, HSHero, HSScene, HSSpell, HSCard, HSWeapon;

typedef enum
{
    hsCardTypeMinion    = 1,
    hsCardTypeSpell     = 2,
    hsCardTypeWeapon    = 3,
    hsCardTypeHero      = 4,
    hsCardTypeSecret    = 5
} hsCardType;

@interface HSDataCenter : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;

@property (nonatomic, strong) NSMutableArray *cardList;

+ (instancetype)sharedInstance;
+ (NSArray*)heroIDList;

- (void)saveContext;

- (HSScene*)newScene;
- (HSHero*)newHero;
- (HSCard*)newCard;
- (HSMinion*)newMinion;
- (HSWeapon*)newWeapon;

@end