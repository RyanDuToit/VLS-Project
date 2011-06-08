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
    int checkRecord;
    int checkPlay;
    UIProgressView *progressBar;
}

@property (nonatomic, retain) IBOutlet UIProgressView *progressBar;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;

- (IBAction)togglePlay:(id)sender;
- (IBAction)toggleRecord:(id)sender;

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@end
