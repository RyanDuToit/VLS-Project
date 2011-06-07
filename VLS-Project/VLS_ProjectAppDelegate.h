//
//  VLS_ProjectAppDelegate.h
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// hi
// new commit

//updated by Bennett at 1:14


#import <UIKit/UIKit.h>

@interface VLS_ProjectAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
