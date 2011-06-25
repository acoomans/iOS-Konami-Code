//
//  main.m
//  iOS-Konami-Code
//
//  Created by Arnaud Coomans on 24/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iOS_Konami_CodeAppDelegate.h"

int main(int argc, char *argv[])
{
	int retVal = 0;
	@autoreleasepool {
	    retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([iOS_Konami_CodeAppDelegate class]));
	}
	return retVal;
}
