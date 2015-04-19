//
//  SKCoreDataManager.h
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SKCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (SKCoreDataManager *) sharedInstance;

- (void)saveContext;

// Get EntityDescriptor to Insert/Fetch records

- (id) getInsertEntityDescription:(NSString *)forEntity;
- (NSEntityDescription *) getFetchEntityDescription:(NSString *)forEntity;

// Fetch All Records

- (NSArray *) fetchAllRecords:(NSString *)forEntity;

// Fetch Record Using Predicate

- (NSArray *) fetchRecords:(NSString *)forEntity forPredicate:(NSPredicate *)predicate;

// Fetch Sorted Record

- (NSArray *) fetchAllRecords:(NSString *)forEntity WithSortDescriptor:(NSString *)sortKey inAsc:(BOOL)isAsc;


// Save Managed Context

- (void) saveManagedContext;

// Delete Record

- (void) deleteObject:(NSManagedObject*) theObject;

// Delete All Records

- (void) deleteAllRecords:(NSString *) forEntity;

// Delete Record Using Predicate

- (void) deleteRecords:(NSString *) forEntity forPredicate:(NSPredicate *)predicate;

@end
