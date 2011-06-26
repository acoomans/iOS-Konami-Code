//
//  iOS_Konami_CodeAppDelegate.h
//  iOS-Konami-Code
//
//  Created by Arnaud Coomans on 26/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iOS_Konami_CodeViewController;

@interface iOS_Konami_CodeAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet iOS_Konami_CodeViewController *viewController;

@end
