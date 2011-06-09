//
//  RecordVC.m
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecordVC.h"
#import <CoreAudio/CoreAudioTypes.h>
#import "Recording.h"
@implementation RecordVC

@synthesize progressBar;
@synthesize recordButton;
@synthesize playButton;
@synthesize audioPlayer;
@synthesize saveButton;
@synthesize audioRecorder;
@synthesize managedObjectContext;

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
    [saveButton release];
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
    // Return YES for supported orientations
	return YES;
}

- (void)viewDidUnload
{
    [self setRecordButton:nil];
    [self setPlayButton:nil];
    [self setProgressBar:nil];
    [self setSaveButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)completed {
    if (completed) {
        [playButton setImage:[UIImage imageNamed:@"play-start.png"] forState:UIControlStateNormal];
        checkPlay++;
        recordButton.enabled = YES;
    }
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
                                    [NSNumber numberWithInt:AVAudioQualityMedium], AVEncoderAudioQualityKey,
                                    nil];
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:[self getSoundURL] settings:recordSettings error:NULL];
    self.audioRecorder.delegate = self;
    [self.audioRecorder prepareToRecord];
}

- (IBAction)togglePlay:(id)sender {
    //play stop
    if (checkPlay%2==1) {
        
        [playButton setImage:[UIImage imageNamed:@"play-start.png"] forState:UIControlStateNormal];
        recordButton.enabled = YES;
        
        [self tearDownAudioSession];
        [self.audioPlayer stop];
        progressBar.progress=0.0;
        
    }
    //play start
    else {
        [playButton setImage:[UIImage imageNamed:@"play-stop.png"] forState:UIControlStateNormal];
        recordButton.enabled = NO;
        
        [self setupAudioSession];
        self.audioPlayer = [[[AVAudioPlayer alloc] initWithContentsOfURL:[self getSoundURL] error:NULL] autorelease];
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        
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
        progressBar.progressViewStyle=UIProgressViewStyleDefault;
        [recordButton setImage:[UIImage imageNamed:@"record-start.png"] forState:UIControlStateNormal];
        playButton.enabled = YES;
        
        [self tearDownAudioSession];
        [self.audioRecorder stop];
        progressBar.progress=0.0;
        
    }
    checkRecord++;
}

- (IBAction)saveAction:(id)sender {
    // get requried stuff
    NSURL *startURL;
    startURL = [self getSoundURL];
    NSDate *timestamp = [[[NSDate alloc] init] autorelease];
    
    NSString *dateString = [timestamp description];
    [dateString stringByReplacingOccurrencesOfString:@":"withString:@"-"];
    
    NSArray *segments = [NSArray arrayWithObjects:NSHomeDirectory(), @"Documents",  [NSString stringWithFormat: @"%@recording.caf",dateString], nil];
    
    NSString *newSoundFilePath = [NSString pathWithComponents:segments];   
    
    NSURL *finalURL = [NSURL alloc];

    [[finalURL initFileURLWithPath:newSoundFilePath] autorelease];

    [[NSFileManager defaultManager] copyItemAtURL:startURL toURL:finalURL error:NULL];

    //Recording *newRecording = [NSEntityDescription insertNewObjectForEntityForName:@"Recording" inManagedObjectContext:self.managedObjectContext];
    //newRecording.fileURL = newSoundFilePath;
    //[self.managedObjectContext save:NULL];
    
}
- (void)updateDisplay {
    if (checkPlay%2==0) {
        progressBar.progress=0;
    }
    else    {
        self.progressBar.progress = self.audioPlayer.currentTime / 
        self.audioPlayer.duration;
    }
}

- (void)viewDidLoad
{
    playButton.enabled = NO;
    checkRecord=0;
    checkPlay=0;
    [NSTimer scheduledTimerWithTimeInterval:.1 
                                     target:self 
                                   selector:@selector(updateDisplay) userInfo:nil repeats:YES];
    [self setupRecorder];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


@end
