//
//  SKCoreDataManager.m
//
//  Created by Admin on 03/06/14.
//

#import "SKCoreDataManager.h"


@implementation SKCoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static SKCoreDataManager *object=nil;

#pragma mark -

- (id)init
{
    self = [super init];
    
	return self;
}

+ (SKCoreDataManager *) sharedInstance
{
    if (!object)
    {
        object=[SKCoreDataManager new];
        [object managedObjectContext];
    }
    
    return object;
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
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ScorekeeperModel" withExtension:@"momd"];
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
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Scorekeeper"];
    
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
        
        NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @(YES),
                                   NSInferMappingModelAutomaticallyOption : @(YES) };
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
	NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[storeURL path] error:&error];
    if (fileAttributes) {
		NSMutableDictionary *updatedAttributed = [[NSMutableDictionary alloc] initWithDictionary:fileAttributes];
		[updatedAttributed addEntriesFromDictionary:[NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey]];
		[[NSFileManager defaultManager] setAttributes:updatedAttributed ofItemAtPath:[storeURL path] error:&error];
    }
	else
	{
		[[NSFileManager defaultManager] setAttributes:[NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey] ofItemAtPath:[storeURL path] error:&error];
	}
	
    return _persistentStoreCoordinator;
}

#pragma mark - Returns the URL to the application's Documents directory.

- (NSURL *)applicationDocumentsDirectory
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    
    return [NSURL fileURLWithPath:documentPath];
}

#pragma mark - Core Data Save Context

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark -
#pragma mark - Get EntityDescriptor to Insert/Fetch records

- (id) getInsertEntityDescription:(NSString *)forEntity
{
    return [NSEntityDescription insertNewObjectForEntityForName:forEntity inManagedObjectContext:self.managedObjectContext];
}

- (NSEntityDescription *) getFetchEntityDescription:(NSString *)forEntity
{
    return [NSEntityDescription entityForName:forEntity inManagedObjectContext:self.managedObjectContext];
}

#pragma mark -
#pragma mark - Fetch All Records

- (NSArray *) fetchAllRecords:(NSString *)forEntity
{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:forEntity inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSArray *allEntityObjects = [self.managedObjectContext executeFetchRequest:request error:nil];
    request = nil;
    
    return allEntityObjects;
}


#pragma mark -66  6
#pragma mark - Fetch Sorted Record

- (NSArray *) fetchAllRecords:(NSString *)forEntity WithSortDescriptor:(NSString *)sortKey inAsc:(BOOL)isAsc
{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:forEntity inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    if(sortKey && (sortKey != NULL))
    {
        NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                                  initWithKey:sortKey ascending:isAsc];
        [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    }
    
    NSArray *allEntityObjects = [self.managedObjectContext executeFetchRequest:request error:nil];
    request = nil;
    
    return allEntityObjects;
}

#pragma mark -
#pragma mark - Fetch Record Using Predicate

- (NSArray *) fetchRecords:(NSString *)forEntity forPredicate:(NSPredicate *)predicate
{
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:forEntity inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSArray *allEntityObjects = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    NSArray *filteredRecord = [allEntityObjects filteredArrayUsingPredicate:predicate];
    request = nil;
    
    return filteredRecord;
}

#pragma mark -
#pragma mark - Check Records for Entity


#pragma mark -
#pragma mark - Save Managed Context

- (void) saveManagedContext
{
    @try
    {
        if(self.managedObjectContext != nil)
        {
            NSError * error;
            
            if ([self.managedObjectContext hasChanges] && ![[self managedObjectContext] save:&error])
                NSLog(@"Unable to save Core Data Changes :%@:", [error description]);
        }
        
    }
    @catch (NSException * e)
    {
		
    }
}

#pragma mark -
#pragma mark - Delete Record

- (void) deleteObject:(NSManagedObject*) theObject
{
    [self.managedObjectContext deleteObject:theObject];
}

#pragma mark -
#pragma mark - Delete All Records

- (void) deleteAllRecords:(NSString *) forEntity
{
    NSError *error = nil;
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:forEntity inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSArray *allEntityObjects = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    for (id managedObject in allEntityObjects)
        [self.managedObjectContext deleteObject:managedObject];
    
    request = nil;
    allEntityObjects = nil;
    
    [self.managedObjectContext save:&error];
}

#pragma mark -
#pragma mark - Delete Record Using Predicate

- (void) deleteRecords:(NSString *) forEntity forPredicate:(NSPredicate *)predicate
{
    NSError *error = nil;
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:forEntity inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSArray *allEntityObjects = [self.managedObjectContext executeFetchRequest:request error:nil];
    NSArray *filteredRecord = [allEntityObjects filteredArrayUsingPredicate:predicate];
    
    for (id managedObject in filteredRecord) {
        [self.managedObjectContext deleteObject:managedObject];
    }
    
    request = nil;
    allEntityObjects = nil;
    
    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSMutableDictionary *) fetchPlayerRecordsForHome:(NSNumber*)gameType
{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game_type == %@", gameType];
    request.predicate = predicate;
    NSArray *allEntityObjects = [self.managedObjectContext executeFetchRequest:request error:nil];
    request = nil;

    return [self indexKeyedDictionaryFromArray:allEntityObjects];
}

- (NSMutableDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array
{
    id objectInstance;
    NSUInteger indexKey = 0U;

    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    for (objectInstance in array)
        [mutableDictionary setObject:objectInstance forKey:[NSNumber numberWithUnsignedInt:indexKey++]];

    return mutableDictionary;
}
@end