//
//  Recording.h
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Annotation;

@interface Recording : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * fileURL;
@property (nonatomic, retain) NSString * Title;
@property (nonatomic, retain) NSSet* annotation;

@end
