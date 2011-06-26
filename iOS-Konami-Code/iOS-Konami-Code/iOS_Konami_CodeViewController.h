//
//  iOS_Konami_CodeViewController.h
//  iOS-Konami-Code
//
//  Created by Arnaud Coomans on 26/06/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOS_Konami_CodeViewController : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet UILabel *buttonATypeLabel;
@property (nonatomic, retain) IBOutlet UIButton *konamiButton;

- (void)konami;
- (IBAction)clear;

@end
