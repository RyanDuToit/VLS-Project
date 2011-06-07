//
//  RecordVC.h
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecordVC : UIViewController {
    
    UIButton *recordButton;
    UIButton *playButton;
    int checkrecord;
}
@property (nonatomic, retain) IBOutlet UIButton *recordButton;

- (IBAction)togglePlay:(id)sender;
- (IBAction)toggleRecord:(id)sender;

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@end
