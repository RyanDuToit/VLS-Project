//
//  RecordVC.m
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecordVC.h"


@implementation RecordVC
@synthesize progressBar;
@synthesize recordButton;
@synthesize playButton;

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

- (void)viewDidLoad
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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
    }
    //record stop
    else {
        progressBar.progress=0.0;
        progressBar.progressViewStyle=UIProgressViewStyleDefault;
        [recordButton setImage:[UIImage imageNamed:@"record-start.png"] forState:UIControlStateNormal];
        playButton.enabled = YES;
    }
    checkRecord++;
}
@end
