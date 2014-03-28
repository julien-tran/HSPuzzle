//
//  HSDataCenter.m
//  HSPuzzle
//
//  Created by Julien Tran on 27/03/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import "HSDataCenter.h"

// Data
#import "HSScene.h"
#import "HSCard.h"
#import "HSMinion.h"
#import "HSHero.h"
#import "HSWeapon.h"

@implementation HSDataCenter

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

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

- (instancetype)init
{
    if (self = [super init])
    {
        [self loadCardList];
    }
    return self;
}

#pragma mark - Core Data stack
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HSModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HSModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Query
- (HSScene*)newScene
{
    HSScene *scene = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([HSScene class])
                                                   inManagedObjectContext:self.managedObjectContext];
    return scene;
}

- (HSHero*)newHero
{
    HSHero *scene = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([HSHero class])
                                                  inManagedObjectContext:self.managedObjectContext];
    return scene;
}

- (HSCard*)newCard
{
    HSCard *card = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([HSCard class])
                                                 inManagedObjectContext:self.managedObjectContext];
    return card;
}

- (HSWeapon*)newWeapon
{
    HSWeapon *card = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([HSWeapon class])
                                                   inManagedObjectContext:self.managedObjectContext];
    return card;
}

- (HSMinion*)newMinion
{
    HSMinion *card = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([HSMinion class])
                                                   inManagedObjectContext:self.managedObjectContext];
    return card;
}

#pragma mark - Data loading
- (void)loadCardList
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"card-neutral" ofType:@"data"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        return;
    
    NSString *fileData = [[NSString alloc] initWithContentsOfFile:filePath
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil];
    NSArray *lines = [fileData componentsSeparatedByString:@"\n"];
    
    for (NSString *line in lines)
    {
        NSArray *components = [line componentsSeparatedByString:@"|"];
        
        // We need at least 3 components to describe a card: card type, card name, mana cost.
        // If the line doesn't contain at least 3 components, it's invalid and is ignored
        if (components.count < 3)
            continue;
        
        int cardType = [components[0] intValue];
        
        // A minion-type card needs at least 5 components. Outside the common card attribute,
        // we need the default attack and health of the minion
        if (hsCardTypeMinion == cardType && components.count < 5)
            continue;
        
        // Similarly, the weapon-type card needs at least 5 components
        if (hsCardTypeWeapon == cardType && components.count < 5)
            continue;
        
        HSCard *aCard = nil;
        if (hsCardTypeWeapon == cardType)
            aCard = self.newWeapon;
        else if (hsCardTypeMinion == cardType)
            aCard = self.newMinion;
        else
            aCard = self.newCard;
        
        aCard.cardType = @(cardType);
        aCard.cardName = components[1];
        aCard.manaCost = @([components[2] intValue]);
        if (hsCardTypeWeapon == cardType)
        {
            ((HSWeapon*)aCard).attackOriginal = @([components[3] intValue]);
            ((HSWeapon*)aCard).durabilityOriginal = @([components[4] intValue]);
        }
        else if (hsCardTypeMinion == cardType)
        {
            HSMinion *minion = (HSMinion*)aCard;
            minion.attackOriginal = @([components[3] intValue]);
            minion.healthOriginal = @([components[4] intValue]);
            if (5 < components.count)
            {
                NSString *specialText = [components[5] lowercaseString];
                if (NSNotFound != [specialText rangeOfString:@"taunt"].location)
                    minion.isTaunt = @(YES);
                if (NSNotFound != [specialText rangeOfString:@"stealth"].location)
                    minion.isStealth = @(YES);
                if (NSNotFound != [specialText rangeOfString:@"divine"].location)
                    minion.divineShield = @(YES);
                if (NSNotFound != [specialText rangeOfString:@"legendary"].location)
                    minion.isLegendary = @(YES);
            }
        }
    }
}

@end