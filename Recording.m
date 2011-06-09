//
//  Recording.m
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Recording.h"
#import "Annotation.h"


@implementation Recording
@dynamic fileURL;
@dynamic Title;
@dynamic annotation;

- (void)addAnnotationObject:(Annotation *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"annotation" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"annotation"] addObject:value];
    [self didChangeValueForKey:@"annotation" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeAnnotationObject:(Annotation *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"annotation" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"annotation"] removeObject:value];
    [self didChangeValueForKey:@"annotation" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addAnnotation:(NSSet *)value {    
    [self willChangeValueForKey:@"annotation" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"annotation"] unionSet:value];
    [self didChangeValueForKey:@"annotation" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeAnnotation:(NSSet *)value {
    [self willChangeValueForKey:@"annotation" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"annotation"] minusSet:value];
    [self didChangeValueForKey:@"annotation" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
