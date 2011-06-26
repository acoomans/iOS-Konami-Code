//
//  UIKonamiGestureRecognizer.m
//  iOS-Konami-Code
//
//  Created by Arnaud Coomans on 24/06/11.
//  Copyright 2011 Arnaud Coomans. All rights reserved.
//

#import "UIKonamiGestureRecognizer.h"


@interface UIKonamiGestureRecognizer ()
- (BOOL)isLeftSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint;
- (BOOL)isRightSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint;
- (BOOL)isUpSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint;
- (BOOL)isDownSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint;
- (BOOL)isZeroSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint;
@end


@implementation UIKonamiGestureRecognizer

@synthesize konamiCodeSequence, moved, timestamp;


- (void)reset {
	NSLog(@"reset");
    [super reset];
	self.moved = NO;
	self.konamiCodeSequence = KonamiCodeSequencePartNone;
	self.timestamp = nil;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"------------------------------------");
	NSLog(@"touchesBegan:withEvent:");
    [super touchesBegan:touches withEvent:event];
	
	NSDate *now = [NSDate date];
	self.moved = NO;
	
	if (	
			([touches count] != 1) ||
			(self.timestamp && [now timeIntervalSinceDate:self.timestamp] > kKonamiGestureDelayMax)
		) {

#if defined(kKonamiGestureFailureGivesStateFailed) && kKonamiGestureFailureGivesStateFailed
		self.state = UIGestureRecognizerStateFailed;
#else
		self.konamiCodeSequence = KonamiCodeSequencePartNone;
		self.timestamp = nil;
#endif
		
	}	
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touchesMoved:withEvent:");
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) return;
	
	self.moved = YES;
	
    CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
    CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
	
	//NSLog(@"nowPoint %@", NSStringFromCGPoint(nowPoint));
	//NSLog(@"prevPoint %@", NSStringFromCGPoint(prevPoint));
	
	
	switch (self.konamiCodeSequence) {
		case KonamiCodeSequencePartNone:
			if (![self isUpSwipeFromPoint:prevPoint toPoint:nowPoint]) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartFirstUp:
			if (![self isUpSwipeFromPoint:prevPoint toPoint:nowPoint]) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartSecondUp:
			if (![self isDownSwipeFromPoint:prevPoint toPoint:nowPoint]) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartFirstDown:
			if (![self isDownSwipeFromPoint:prevPoint toPoint:nowPoint]) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartSecondDown:
			if (![self isLeftSwipeFromPoint:prevPoint toPoint:nowPoint]) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartFirstLeft:
			if (![self isRightSwipeFromPoint:prevPoint toPoint:nowPoint]) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartFirstRight:
			if (![self isLeftSwipeFromPoint:prevPoint toPoint:nowPoint]) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartSecondLeft:
			if (![self isRightSwipeFromPoint:prevPoint toPoint:nowPoint]) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartSecondRight:
		case KonamiCodeSequencePartB:
		case KonamiCodeSequencePartA:
		default:
			self.state = UIGestureRecognizerStateFailed;
			break;
	}
	
	if (self.state == UIGestureRecognizerStateFailed) {
		NSLog(@"failed");
	}
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touchesEnded:withEvent:");
    [super touchesEnded:touches withEvent:event];
	
	switch (self.konamiCodeSequence) {
		case KonamiCodeSequencePartNone:
		case KonamiCodeSequencePartFirstUp:
		case KonamiCodeSequencePartSecondUp:
		case KonamiCodeSequencePartFirstDown:
		case KonamiCodeSequencePartSecondDown:
		case KonamiCodeSequencePartFirstLeft:
		case KonamiCodeSequencePartFirstRight:
		case KonamiCodeSequencePartSecondLeft:
			if (!self.moved) {
				self.state = UIGestureRecognizerStateFailed;
			}
			break;
			
		case KonamiCodeSequencePartSecondRight:
			// nothing here
			break;
		case KonamiCodeSequencePartB:
#if defined (kKonamiGestureButtonADoubleTap) && !kKonamiGestureButtonADoubleTap
			self.konamiCodeSequence += 1;		
#endif
			// nothing here
			break;
			
		case KonamiCodeSequencePartA:;
#if defined (kKonamiGestureButtonADoubleTap) && kKonamiGestureButtonADoubleTap
			NSLog(@"KonamiCodeSequencePartA doubleTap");
			
			NSDate *now = [NSDate date];
			if (self.timestamp && [now timeIntervalSinceDate:self.timestamp] > kKonamiGestureDoubleTapDelayMax) {
				self.state = UIGestureRecognizerStateFailed;
			}
#endif
			break;
			
		default:
			break;
	}
	
	if ((self.state == UIGestureRecognizerStatePossible) && konamiCodeSequence == KonamiCodeSequencePartA) {
        self.state = UIGestureRecognizerStateRecognized;
		
    } else if (self.state != UIGestureRecognizerStateFailed) {
	
		self.konamiCodeSequence += 1;
		NSLog(@"sequence %d", self.konamiCodeSequence);
	
		NSDate *now = [NSDate date];
		self.timestamp = now;
	}
	
}



- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touchesCancelled:withEvent:");
    [super touchesCancelled:touches withEvent:event];
	self.konamiCodeSequence = KonamiCodeSequencePartNone;
    self.state = UIGestureRecognizerStateFailed;
}



#pragma mark - 


- (BOOL)isLeftSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint {
	float deltaX = nowPoint.x - prevPoint.x;
	float deltaY = nowPoint.y - prevPoint.y;
	//NSLog(@"deltaX/deltaY: %f,%f", deltaX, deltaY);
	return (
			(deltaX < -kKonamiGestureDistanceMin ) &&
			(abs(deltaY) <= abs(deltaX)*kKonamiGestureDeltaTolerance)
	);
}

- (BOOL)isRightSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint {
	float deltaX = nowPoint.x - prevPoint.x;
	float deltaY = nowPoint.y - prevPoint.y;
	//NSLog(@"deltaX/deltaY: %f,%f", deltaX, deltaY);
	return (
			(deltaX > kKonamiGestureDistanceMin ) &&
			(abs(deltaY) <= abs(deltaX)*kKonamiGestureDeltaTolerance)
			);
}

- (BOOL)isUpSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint {
	float deltaX = nowPoint.x - prevPoint.x;
	float deltaY = nowPoint.y - prevPoint.y;
	//NSLog(@"deltaX/deltaY: %f,%f", deltaX, deltaY);
	return (
			(deltaY < -kKonamiGestureDistanceMin ) &&
			(abs(deltaX) <= abs(deltaY)*kKonamiGestureDeltaTolerance)
			);
}

- (BOOL)isDownSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint {
	float deltaX = nowPoint.x - prevPoint.x;
	float deltaY = nowPoint.y - prevPoint.y;
	//NSLog(@"deltaX/deltaY: %f,%f", deltaX, deltaY);
	return (
			(deltaY > kKonamiGestureDistanceMin ) &&
			(abs(deltaX) <= abs(deltaY)*kKonamiGestureDeltaTolerance)
			);
}


- (BOOL)isZeroSwipeFromPoint:(CGPoint)prevPoint toPoint:(CGPoint)nowPoint {
	float deltaX = nowPoint.x - prevPoint.x;
	float deltaY = nowPoint.y - prevPoint.y;
	//NSLog(@"deltaX/deltaY: %f,%f", deltaX, deltaY);
	return (
			(abs(deltaX)<3) &&
			(abs(deltaY)<3)
			);
}

@end
