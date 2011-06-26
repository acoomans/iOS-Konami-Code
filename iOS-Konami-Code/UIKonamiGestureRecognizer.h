//
//  UIKonamiGestureRecognizer.h
//  iOS-Konami-Code
//
//  Created by Arnaud Coomans on 24/06/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>


#define kKonamiGestureDeltaTolerance 0.8
#define kKonamiGestureDistanceMin 1
#define kKonamiGestureDelayMax 0.8
#define kKonamiGestureDoubleTapDelayMax 0.3

#define kKonamiGestureFailureGivesStateFailed 0
#define kKonamiGestureButtonADoubleTap 1


typedef enum _KonamiCodeSequencePart {
	KonamiCodeSequencePartNone = 0,
	
	KonamiCodeSequencePartFirstUp,
	KonamiCodeSequencePartSecondUp,
	
	KonamiCodeSequencePartFirstDown,
	KonamiCodeSequencePartSecondDown,

	KonamiCodeSequencePartFirstLeft,
	KonamiCodeSequencePartFirstRight,
	
	KonamiCodeSequencePartSecondLeft,
	KonamiCodeSequencePartSecondRight,
	
	KonamiCodeSequencePartB, // single tap
	KonamiCodeSequencePartA, // single tap or double tap if kKonamiGestureButtonAisDoubleTap is set to 1
	
} KonamiCodeSequencePart;


@interface UIKonamiGestureRecognizer : UIGestureRecognizer

@property (nonatomic, assign) KonamiCodeSequencePart konamiCodeSequence;
@property (nonatomic, assign) BOOL moved;
@property (nonatomic, retain) NSDate *timestamp;

- (void)reset;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
