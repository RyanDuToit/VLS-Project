//
//  RecordVC.h
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordVC : UIViewController <AVAudioRecorderDelegate,
AVAudioSessionDelegate, AVAudioPlayerDelegate> {
    UIButton *recordButton;
    UIButton *playButton;
    int checkRecord;
    int checkPlay;
    UIProgressView *progressBar;
}

@property (nonatomic, retain) IBOutlet UIProgressView *progressBar;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) AVAudioRecorder *audioRecorder;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

- (IBAction)togglePlay:(id)sender;
- (IBAction)toggleRecord:(id)sender;

@end
