//
//  iOS_Konami_CodeViewController.m
//  iOS-Konami-Code
//
//  Created by Arnaud Coomans on 26/06/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import "iOS_Konami_CodeViewController.h"
#import "UIKonamiGestureRecognizer.h"
#import <QuartzCore/QuartzCore.h>

@implementation iOS_Konami_CodeViewController

@synthesize buttonATypeLabel, konamiButton;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
#if defined (kKonamiGestureButtonADoubleTap) && kKonamiGestureButtonADoubleTap
	self.buttonATypeLabel.text = @"A is a double tap";
#else 
	self.buttonATypeLabel.text = @"A is a single tap";	
#endif
	
	UIKonamiGestureRecognizer *k = [[UIKonamiGestureRecognizer alloc] initWithTarget:self action:@selector(konami)];
	[self.view addGestureRecognizer:k];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)konami {
	[self.konamiButton setTitle:@"いいですよ!" forState:UIControlStateNormal];
	self.konamiButton.layer.borderColor = [[UIColor greenColor] CGColor];
	self.konamiButton.layer.borderWidth = 2;
	
	NSLog(@"konami code complete!");
}

- (void)clear {
	[self.konamiButton setTitle:@"" forState:UIControlStateNormal];
	self.konamiButton.layer.borderColor = [[UIColor clearColor] CGColor];
	self.konamiButton.layer.borderWidth = 2;
}

@end
