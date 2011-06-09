//
//  Annotation.h
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recording;

@interface Annotation : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * timeStamp;
@property (nonatomic, retain) NSString * Summary;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) Recording * recording;

@end
