//
//  HSHero.h
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HSCard, HSMinion, HSScene;

@interface HSHero : NSManagedObject

@property (nonatomic, retain) NSNumber * isVillain;
@property (nonatomic, retain) NSNumber * healthMax;
@property (nonatomic, retain) NSNumber * healthCurrent;
@property (nonatomic, retain) NSNumber * armorCurrent;
@property (nonatomic, retain) NSNumber * attackCurrent;
@property (nonatomic, retain) NSNumber * manaCurrent;
@property (nonatomic, retain) NSString * heroID;
@property (nonatomic, retain) NSOrderedSet *minions;
@property (nonatomic, retain) HSScene *scene;
@property (nonatomic, retain) NSOrderedSet *cards;
@end

@interface HSHero (CoreDataGeneratedAccessors)

- (void)insertObject:(HSMinion *)value inMinionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMinionsAtIndex:(NSUInteger)idx;
- (void)insertMinions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMinionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMinionsAtIndex:(NSUInteger)idx withObject:(HSMinion *)value;
- (void)replaceMinionsAtIndexes:(NSIndexSet *)indexes withMinions:(NSArray *)values;
- (void)addMinionsObject:(HSMinion *)value;
- (void)removeMinionsObject:(HSMinion *)value;
- (void)addMinions:(NSOrderedSet *)values;
- (void)removeMinions:(NSOrderedSet *)values;

- (void)insertObject:(HSCard *)value inCardsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCardsAtIndex:(NSUInteger)idx;
- (void)insertCards:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCardsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCardsAtIndex:(NSUInteger)idx withObject:(HSCard *)value;
- (void)replaceCardsAtIndexes:(NSIndexSet *)indexes withCards:(NSArray *)values;
- (void)addCardsObject:(HSCard *)value;
- (void)removeCardsObject:(HSCard *)value;
- (void)addCards:(NSOrderedSet *)values;
- (void)removeCards:(NSOrderedSet *)values;
@end
