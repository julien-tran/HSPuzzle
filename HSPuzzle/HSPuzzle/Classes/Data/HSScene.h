//
//  HSScene.h
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HSHero;

@interface HSScene : NSManagedObject

@property (nonatomic, retain) NSNumber * turnNumber;
@property (nonatomic, retain) NSSet *heroes;
@end

@interface HSScene (CoreDataGeneratedAccessors)

- (void)addHeroesObject:(HSHero *)value;
- (void)removeHeroesObject:(HSHero *)value;
- (void)addHeroes:(NSSet *)values;
- (void)removeHeroes:(NSSet *)values;

@end
