//
//  RecordVC.m
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecordVC.h"
#import <CoreAudio/CoreAudioTypes.h>

@implementation RecordVC
@synthesize progressBar;
@synthesize recordButton;
@synthesize playButton;
@synthesize audioPlayer;
@synthesize audioRecorder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [recordButton release];
    [playButton release];
    [progressBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    progressBar.progress=0.0;
    playButton.enabled = NO;
    checkRecord=0;
    checkPlay=0;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setRecordButton:nil];
    [self setPlayButton:nil];
    [self setProgressBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(NSURL *) getSoundURL {
    NSArray *segments = [NSArray arrayWithObjects:NSHomeDirectory(), @"Documents", @"recording.caf", nil];
    NSString *soundFilePath = [NSString pathWithComponents:segments];
    return [[[NSURL alloc] initFileURLWithPath:soundFilePath] autorelease];
}

-(void) setupAudioSession {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    audioSession.delegate = self;
    [audioSession setActive:YES error:NULL];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
}

-(void) tearDownAudioSession {
    [[AVAudioSession sharedInstance] setActive:NO error:NULL];
}

-(void) setupRecorder {
    [self setupAudioSession];
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                    [NSNumber numberWithInt:kAudioFormatAppleLossless], AVFormatIDKey,
                                    [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                    [NSNumber numberWithInt:AVAudioQualityMax], AVEncoderAudioQualityKey,
                                    nil];
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:[self getSoundURL] settings:recordSettings error:NULL];
    self.audioRecorder.delegate = self;
    [self.audioRecorder prepareToRecord];
}

- (IBAction)togglePlay:(id)sender {
    //play start
    if (checkPlay%2==1) {
        
        [playButton setImage:[UIImage imageNamed:@"play-start.png"] forState:UIControlStateNormal];
        recordButton.enabled = YES;
        
    }
    //play stop
    else {
        [playButton setImage:[UIImage imageNamed:@"play-stop.png"] forState:UIControlStateNormal];
        recordButton.enabled = NO;
        progressBar.progress=0;
    }
    checkPlay++;
}

- (IBAction)toggleRecord:(id)sender {

    //record start
    if (checkRecord%2==0) {
        progressBar.progress=0.0;
        progressBar.progressViewStyle=UIProgressViewStyleBar;
        [recordButton setImage:[UIImage imageNamed:@"record-stop.png"] forState:UIControlStateNormal];
        playButton.enabled = NO;
       
        [self setupAudioSession];
        [self.audioRecorder record];
    }
    //record stop
    else {
        progressBar.progress=0.0;
        progressBar.progressViewStyle=UIProgressViewStyleDefault;
        [recordButton setImage:[UIImage imageNamed:@"record-start.png"] forState:UIControlStateNormal];
        playButton.enabled = YES;
        
        [self tearDownAudioSession];
        [self.audioRecorder stop];
    }
    checkRecord++;
}

- (void)viewDidLoad
{
    playButton.enabled = NO;
    checkRecord=0;
    checkPlay=0;
    [self setupRecorder];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setRecordButton:nil];
    [self setPlayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
