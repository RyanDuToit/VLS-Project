//
//  RecordVC.m
//  VLS-Project
//
//  Created by Ryan Dutoit on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RecordVC.h"


@implementation RecordVC
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
    playButton.enabled = NO;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)togglePlay:(id)sender {

}

- (IBAction)toggleRecord:(id)sender {
        //switch to record image
    //if([recordButton.currentImage isEqual:[UIImage imageNamed:@"record-play.png"]])
    if (checkrecord%2==0) {
            [recordButton setImage:[UIImage imageNamed:@"record-stop.png"] forState:UIControlStateNormal];
    }

    
    
    else
    {
         [recordButton setImage:[UIImage imageNamed:@"record-start.png"] forState:UIControlStateNormal];
    }
    checkrecord++;
}
@end
