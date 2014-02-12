//
//  imageDrop.m
//  iOS Artwork
//
//  Created by Paul Derbyshire on 12/02/2014.
//  Copyright (c) 2014 Resonance. All rights reserved.
//

#import "imageDrop.h"

@implementation imageDrop


- (id)initWithFrame:(NSRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[self registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
	}
	return self;
}

- (void)setDelegate:(id<imageDropDelegate>)_delegate {
    delegate = _delegate;
}



- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender{
	highlight=YES;
	[self setNeedsDisplay: YES];
	return NSDragOperationGeneric;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender{
	highlight=NO;
	[self setNeedsDisplay: YES];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
	highlight=NO;
	[self setNeedsDisplay: YES];
	return YES;
}

- (BOOL)performDragOperation:(id < NSDraggingInfo >)sender {
	return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender{
	NSArray *draggedFilenames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
	[delegate filesDropped:draggedFilenames];
}

- (void)drawRect:(NSRect)rect{
	[super drawRect:rect];
	if ( highlight ) {
		[[NSColor grayColor] set];
		[NSBezierPath setDefaultLineWidth: 5];
		[NSBezierPath strokeRect: [self bounds]];
	}
}

@end
